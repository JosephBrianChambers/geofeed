module Twitter
  class Client
    PAGINATION_THRESHOLD = 10

    attr_accessor :pagination_count

    def initialize
      @pagination_count = 0
    end

    def geo_fence_tweets(geojson_polygon, start_time:, end_time:, &block)
      t_geojson = ::Twitter::GeojsonDecorator.new(geojson_polygon)

      params = {
        result_type: "recent",
        count: 100,
        include_entities: true,
        geocode: [t_geojson.centroid_lat, t_geojson.centroid_lng, t_geojson.radius / 1_000.0].join(",") + "km",
      }

      paginate_search_query("?#{params.to_query}", start_time, end_time, &block)
    end

    def paginate_search_query(query_string, start_time, end_time, &block)
      raise "endless paginating!" if (self.pagination_count += 1) >= PAGINATION_THRESHOLD

      response = api_client.search_query(query_string)
      raw_tweets = response["statuses"]

      raw_tweets.each do |raw_tweet|
        next unless within_time_box?(start_time, end_time, Time.parse(raw_tweet["created_at"]))

        block.yield raw_tweet
      end

      if time_paginate?(response, start_time, end_time)
        paginate_search_query(response["search_metadata"]["next_resutls"], start_time, end_time &block)
      end
    end

    private

    def time_paginate?(response, start_time, end_time)
      return false unless response.dig("search_metadata","next_resutls").present?
      return false unless response["statuses"].present?

      within_time_box?(start_time, end_time, raw_tweets.first["created_at"])
    end

    def within_time_box?(start_time, end_time, test_time)
      start_time < test_time && test_time < end_time
    end

    def api_client
      ::Twitter::ApiClient.new
    end
  end
end
