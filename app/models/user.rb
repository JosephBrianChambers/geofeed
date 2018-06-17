class User < ApplicationRecord
  has_secure_password

  has_many :todos, foreign_key: :created_by
  has_one :provider_access_token

  validates :email, presence: true
  validates :name, presence: true
end
