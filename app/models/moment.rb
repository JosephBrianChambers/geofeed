# reference
# http://geojsonlint.com/
# http://geojson.io
# https://postgis.net/docs/manual-1.3/ch06.html
# https://stackoverflow.com/questions/46298611/how-to-find-all-points-within-polygon-in-postgis

class Moment < ApplicationRecord
  FACTORY = RGeo::Geographic.simple_mercator_factory

  has_many :event_moments
  has_many :events, through: :event_moments
  belongs_to :content_provider

  validates :loc, presence: true
  validates :title, presence: true
  validates :author_id, presence: true
  validates :content_privider_id, presence: true

  def self.within_polygon(geojson_polygon)
    rgeo_geom = RGeo::GeoJSON.decode(geojson_polygon, json_parser: :json, geo_factory: FACTORY)
    projected_polygon = FACTORY.project(rgeo_geom.geometry)
    projected_wkt = projected_polygon.as_text
    Moment.where("ST_Contains(ST_PolygonFromText(?), moments.loc)", 'SRID=3857;' + projected_wkt)
  end

  def loc_geo
    FACTORY.unproject(self.loc)
  end

  def loc_geo=(value)
    self.loc = FACTORY.project(value)
  end
end
