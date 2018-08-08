# reference
# http://geojsonlint.com/
# http://geojson.io
# https://postgis.net/docs/manual-1.3/ch06.html
# https://stackoverflow.com/questions/46298611/how-to-find-all-points-within-polygon-in-postgis

class Moment < ApplicationRecord
  # TODO: extract mercator factory, geojson decode/encode functionality into module/consern
  FACTORY = RGeo::Geographic.simple_mercator_factory
  PROVIDER_DUPLICATE_MESSAGE = "provider moment already exists"

  has_many :event_moments
  has_many :events, through: :event_moments
  has_many :medias
  belongs_to :content_provider
  belongs_to :author, primary_key: :provider_id, foreign_key: :provider_author_id

  validates :loc, presence: true
  validates :provider_author_id, presence: true
  validates :content_provider_id, presence: true
  validates :provider_id,
    presence: true,
    uniqueness: { scope: :content_provider_id, message: PROVIDER_DUPLICATE_MESSAGE }

  def self.within_polygon(geojson_polygon)
    rgeo_geom = RGeo::GeoJSON.decode(geojson_polygon, json_parser: :json, geo_factory: FACTORY)
    projected_polygon = FACTORY.project(rgeo_geom.geometry)
    projected_wkt = projected_polygon.as_text
    Moment.where("ST_Contains(ST_PolygonFromText(?), moments.loc)", 'SRID=3857;' + projected_wkt)
  end

  def loc_geo
    FACTORY.unproject(self.loc)
  end

  def loc_geo=(geo_geometry)
    self.loc = FACTORY.project(geo_geometry)
  end

  def lng_lat=(longitude_latitude)
    self.loc_geo = FACTORY.point(*longitude_latitude)
  end

  def geojson
    RGeo::GeoJSON.encode(loc_geo)
  end

  # def lng_lat
  #   [loc_geo.lon, loc_geo.lat]
  # end
end
