class Api::V1::AuthenticationController < ApiBaseController
  skip_before_action :authorize_request, only: [:authenticate, :authenticate_from_oauth]

  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(nil)
    cookies.signed.permanent[:jwt] = auth_token
  end

  def authenticate_from_oauth
    user = upsert_user_from_auth_hash(request.env['omniauth.auth'])
    auth_token = AuthenticateUser.new(user.email, user.password).call
    cookies.signed.permanent[:jwt] = auth_token
    redirect_to  "/user_map_page"
  end

  private

  def auth_params
    params.permit(:email, :password)
  end

  def upsert_user_from_auth_hash(auth_hash)
    user_attrs = {
      email: auth_hash["info"]["email"] || "foo#{Time.now.to_i}@bar.com",
      name: auth_hash["info"]["name"],
      password: SecureRandom.uuid,
    }

    user = User.find_by(email: user_attrs[:email]) || User.new
    user.update_attributes!(user_attrs)

    token_attrs = {
      user: user,
      content_provider_id: ContentProvider[auth_hash["provider"]].id,
      token: auth_hash["credentials"]["token"],
      # expires: auth_hash["credentials"]["expires"], TODO: update when more scenarios (true/false/date/integer) (not needed now)
    }

    provider_access_token = user.provider_access_token || ProviderAccessToken.new
    provider_access_token.update_attributes!(token_attrs)

    user
  end
end
