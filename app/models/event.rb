class Event < ApplicationRecord
  FACTORY = RGeo::Geographic.simple_mercator_factory

  has_many :moments

  def loc_fence_geo=(geo_polygon)
    self.loc_fence = FACTORY.project(geo_polygon)
  end

  def loc_fence_geo
    FACTORY.unproject(self.loc_fence)
  end
end
