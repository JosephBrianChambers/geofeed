FactoryBot.define do
  factory :provider_access_token do
    user_id 1
    token "MyString"
    expires_at "2018-06-17 12:56:01"
    content_provider_id 1
  end
end
