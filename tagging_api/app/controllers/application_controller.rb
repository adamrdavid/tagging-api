require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  
  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(authorization_token: token)
    end
  end
end
