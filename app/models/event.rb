class Event < ApplicationRecord
  FACTORY = RGeo::Geographic.simple_mercator_factory

  has_many :event_moments
  has_many :moments, through: :event_moments

  validates :loc_fence, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  def loc_fence_geo=(geo_polygon)
    self.loc_fence = FACTORY.project(geo_polygon)
  end

  def loc_fence_geo
    FACTORY.unproject(self.loc_fence)
  end
end
