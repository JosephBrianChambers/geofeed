module Twitter
  class GeojsonDecorator < SimpleDelegator
    def initialize(geojson_polygon)
      super(geojson_polygon)
    end

    def centroid_lat
      mercator_geometry.centroid.latitude
    end

    def centroid_lng
      mercator_geometry.centroid.longitude
    end

    def radius
      factory = RGeo::Geographic.spherical_factory
      centroid = factory.point(centroid_lng, centroid_lat)
      geometry = RGeo::GeoJSON.decode(object, json_parser: :json, geo_factory: factory)
      geometry.exterior_ring.points.map { |p| centroid.distance(p) }.max # meters
    end

    private

    def mercator_geometry
      factory = RGeo::Geographic.simple_mercator_factory
      @geometry ||= RGeo::GeoJSON.decode(object, json_parser: :json, geo_factory: factory)
    end

    def object
      __getobj__
    end
  end
end
