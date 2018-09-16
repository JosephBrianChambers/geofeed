module Citizen
  class Client
    PAGINATION_THRESHOLD = 10

    attr_accessor :pagination_count

    def initialize
      @pagination_count = 0
    end

    def geo_fence_alerts(event, start_time:, end_time:, &block)
      bbox = RGeo::Cartesian::BoundingBox.create_from_geometry(event.loc_fence_geo)

      params = {
        lowerLatitude: bbox.min_y,
        upperLatitude: bbox.max_y,
        lowerLongitude: bbox.min_x,
        upperLongitude: bbox.max_y,
      }

      api_client.incidents_nearby(params).each { |raw_alert| yield(raw_alert) }
    end

    private

    def api_client
      ::Citizen::ApiClient.new
    end
  end
end
