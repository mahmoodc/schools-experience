FactoryBot.define do
  factory :schools_on_boarding_phase_subject, class: 'Schools::OnBoarding::PhaseSubject' do
    schools_school_profile { nil }
    bookings_phase { nil }
    bookings_subject { nil }
  end
end
