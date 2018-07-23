FactoryBot.define do
  factory :author do
    content_provider

    avatar_url "http://foo.net/bar"
    name "Tom"
    email "t@example.com"
    handle "tcool"

    sequence(:provider_id) { |n| "992385x00994#{n}" }
  end
end
