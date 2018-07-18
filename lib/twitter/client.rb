module Twitter
  class Client
    def geo_fence_tweets(geojson_polygon, start_time:, end_time:, &block)
      t_geojson = Twitter::GeoJsonDecorator.new(geojson_polygon)
      params = { lat: t_geojson.centroid_lat, lng: t_geojson.centroid_lng, radius: t_geojson.radius }
      time_paginate_search_tweets(params, start_time, end_time, &block)
    end

    private

    def time_paginate_search_tweets(params, start_time, end_time, &block)
      raw_tweets = api_client.search_tweets(params)["statuses"]

      raw_tweets.each do |raw_tweet|
        next if within_time_box?(start_time, end_time, Time.at(raw_tweet["created_at"]))

        yield raw_tweet
      end

      # if ((last_tweet = raw_tweets.last) && within_time_box?(start_time, end_time, last_tweet["created_at"]))
      #   time_paginate_search_tweets(params.merge("max_id" => last_tweet["id_str"]), start_time, end_time)
      # end
    end

    def within_time_box?(start_time, end_time, test_time)
      start_time < test_time && test_time < end_time
    end

    def api_client
      Twitter::ApiClient.new
    end
  end
end
