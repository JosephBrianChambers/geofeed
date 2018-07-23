class Author < ApplicationRecord
  PROVIDER_DUPLICATE_MESSAGE = "provider author already exists"

  has_many :moments, primary_key: :provider_id, foreign_key: :provider_author_id
  belongs_to :content_provider

  validates :avatar_url, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }, allow_nil: true
  validates :content_provider_id, presence: true
  validates :provider_id,
    presence: true,
    uniqueness: { scope: :content_provider_id, message: PROVIDER_DUPLICATE_MESSAGE }
  validate :has_pen_name

  private

  def has_pen_name
    errors.add(:pen_name, "Pen Name must exist") unless (name || email || handle).present?
  end
end
