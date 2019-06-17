class Media < ApplicationRecord
  belongs_to :moment

  validates :moment, presence: true
  validates :url, presence: true
end
