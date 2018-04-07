class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :redirect_url
  before_filter :set_mailer_host

  def set_mailer_host
    ActionMailer::Base.default_url_options[:host] = request.base_url
  end
  def redirect_url
    return new_patron_session_path unless patron_signed_in?
    case current_patron
      when User
        root_path
      when Admin
        root_path
    end
  end
end
