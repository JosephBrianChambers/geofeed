
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :instagram,
    Rails.application.secrets.instagram_client_id,
    Rails.application.secrets.instagram_client_secret,
    scope: ['basic', 'public_content'],
    enforce_signed_requests: true
end
