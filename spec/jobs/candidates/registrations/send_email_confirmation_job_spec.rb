require 'rails_helper'

describe Candidates::Registrations::SendEmailConfirmationJob, type: :job do
  include_context 'Stubbed candidates school'
  include ActiveSupport::Testing::TimeHelpers

  let :registration_session do
    FactoryBot.build :registration_session
  end

  let :uuid do
    'some-uuid'
  end

  let :host do
    'www.example.com'
  end

  let :notification do
    double NotifyEmail::CandidateMagicLink, despatch!: true
  end

  before do
    ActiveJob::Base.queue_adapter = :inline

    allow(SecureRandom).to receive(:urlsafe_base64) { uuid }

    Candidates::Registrations::RegistrationStore.instance.store! \
      registration_session

    allow(NotifyEmail::CandidateMagicLink).to receive(:new) { notification }
  end

  after do
    # Clean up redis
    Candidates::Registrations::RegistrationStore.instance.delete! uuid
  end

  context '#perform' do
    context 'with errors' do
      context 'retryable error' do
        let :a_decent_amount_longer do
          8.hours.from_now.to_i
        end

        let :number_of_executions do
          4
        end

        before do
          allow_any_instance_of(described_class).to receive(:executions) do
            number_of_executions
          end

          allow(described_class.queue_adapter).to receive :enqueue_at

          allow(notification).to receive :despatch! do
            raise Notify::RetryableError
          end

          freeze_time # so we can easily compare a decent_amount_longer from now

          described_class.perform_later uuid, host
        end

        it 'reenqueues the job' do
          expect(described_class.queue_adapter).to \
            have_received(:enqueue_at).with \
              an_instance_of(described_class), a_decent_amount_longer
        end
      end

      context 'non retryable error' do
        let :response_error_message do
          double Net::HTTPResponse, code: 400, body: 'oh no!'
        end

        let :application_job_retry_limit do
          3
        end

        before do
          allow(notification).to receive :despatch! do
            raise Notifications::Client::RequestError, response_error_message
          end

          allow_any_instance_of(described_class).to receive :executions do
            application_job_retry_limit
          end
        end

        it 'lets the error propogate' do
          expect { described_class.perform_later uuid, host }.to raise_error \
            Notifications::Client::RequestError
        end
      end
    end

    context 'without errors' do
      before do
        described_class.perform_later uuid, host
      end

      it 'builds the email correctly' do
        expect(NotifyEmail::CandidateMagicLink).to have_received(:new).with \
          to: 'test@example.com',
          school_name: 'Test School',
          confirmation_link: 'http://www.example.com/candidates/confirm/some-uuid'
      end

      it 'sends the email' do
        expect(notification).to have_received :despatch!
      end
    end
  end
end
