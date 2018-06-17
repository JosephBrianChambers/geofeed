class ProviderAccessToken < ApplicationRecord
  belongs_to :user
  belongs_to :content_provider

  validates :user_id, presence: true
  validates :content_provider_id, presence: true
  validates :token, presence: true
end
