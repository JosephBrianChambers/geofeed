class ContentProvider < ApplicationRecord
  has_many :authors
  has_many :moments, through: :authors

  validates :name, presence: true
  validates :code, presence: true

  def self.[](code)
    find_by(code: code)
  end
end
