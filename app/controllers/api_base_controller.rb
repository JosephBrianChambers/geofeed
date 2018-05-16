class ApiBaseController < ActionController::API
  include ActionController::Cookies
  include Response
  include ExceptionHandler

  before_action :authorize_request

  attr_reader :current_user

  private

  def authorize_request
    @current_user = (AuthorizeApiRequest.new(cookies.signed[:jwt]).call)[:user]
  end
end
