class ApplicationController < ActionController::Base
  rescue_from ActionController::InvalidAuthenticityToken, with: :session_expired

  CRAWLABLE_PATHS = %w{/ /candidates}.freeze
  before_action :add_x_robots_tag

protected

  def add_x_robots_tag
    headers["X-Robots-Tag"] = if request.path.in?(CRAWLABLE_PATHS)
                                "all"
                              else
                                "none"
                              end
  end

  def http_basic_authenticate
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['SECURE_USERNAME'] && password == ENV['SECURE_PASSWORD']
    end
  end

  def session_expired(exception)
    ExceptionNotifier.notify_exception(exception)
    Raven.capture_exception(exception)

    render 'shared/session_expired'
  end
end
