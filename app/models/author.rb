class Author < ApplicationRecord
  has_many :moments
  belongs_to :content_provider

  validates :avatar_url, presence: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }, allow_nil: true
  validates :content_provider_id, presence: true
  validate :has_pen_name

  private

  def has_pen_name
    errors.add(:pen_name, "Pen Name must exist") unless (name || email || handle).present?
  end
end
