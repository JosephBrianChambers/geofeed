class Media < ApplicationRecord
  belongs_to :moment

  validates :moment_id, presence: true
  validates :url, presence: true
end
