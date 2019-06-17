class Event < ApplicationRecord
  FACTORY = RGeo::Geographic.simple_mercator_factory

  has_many :event_moments
  has_many :moments, through: :event_moments, dependent: :destroy

  validates :loc_fence, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :validate_geo_location

  def loc_fence_geo=(geo_polygon)
    self.loc_fence = FACTORY.project(geo_polygon)
  end

  def loc_fence_geo
    FACTORY.unproject(self.loc_fence)
  end

  def geojson
    RGeo::GeoJSON.encode(loc_fence_geo)
  end

  def includes_lng_lat?(lng_lat)
    cartesian_point = FACTORY.point(*lng_lat).projection
    loc_fence.contains?(cartesian_point)
  end

  private

  def validate_geo_location
    geojson_polygon = {
      "type" => "Feature",
      "properties" => {},
      "geometry" => {
        "type"=>"Polygon",
        "coordinates"=>[
          [
            [-122.53738403320312,37.6892542140253],
            [-122.33757019042969,37.6892542140253],
            [-122.33757019042969,37.81792077237497],
            [-122.53738403320312,37.81792077237497],
            [-122.53738403320312, 37.6892542140253],
          ]
        ],
      },
    }

    sf_rgeo_geom = RGeo::GeoJSON.decode(geojson_polygon, json_parser: :json, geo_factory: FACTORY).geometry
    errors.add(:geo_fence, "cannot be outside San Francisco") unless sf_rgeo_geom.contains?(loc_fence_geo)
  end
end
