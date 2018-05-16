class Api::V1::AuthenticationController < ApiBaseController
  skip_before_action :authorize_request, only: :authenticate

  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(nil)
    cookies.signed.permanent[:jwt] = auth_token
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
