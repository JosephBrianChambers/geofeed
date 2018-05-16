class AuthorizeApiRequest
  attr_reader :alleged_jwt

  def initialize(alleged_jwt)
    raise(ExceptionHandler::MissingToken, Message.missing_token) unless alleged_jwt

    @alleged_jwt = alleged_jwt
  end

  def call
    {
      user: user
    }
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_jwt[:user_id]) if decoded_jwt
  rescue ActiveRecord::RecordNotFound => e
    raise ExceptionHandler::InvalidToken, "#{Message.invalid_token} #{e.message}"
  end

  def decoded_jwt
    @decoded_jwt ||= JsonWebToken.decode(alleged_jwt)
  end
end
