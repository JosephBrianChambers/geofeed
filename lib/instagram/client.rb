module Instagram
  class Client
    def geo_fence_media(geojson_polygon, start_time:, end_time:)
      ig_geojson = Instagram::GeoJsonDecorator.new(geojson_polygon)
      response = api_client.locations_search(ig_geojson.center, ig_geojson.radius)

      response["locations"].each do |raw_location|
        location_media(raw_location["id"], start_time: start_time, end_time: end_time) do |raw_medias|

          yield filter_out_location_outside_geo(ig_geojson, raw_medias)
        end
      end
    end

    def location_media(location_id, start_time:, end_time:)
      response = api_client.location_media(location_id, start_time: start_time, end_time: end_time)
      raw_medias = reject_published_at_lt(time, response["medias"])
      yield time_bounded_media
      raw_medias.last && chrono_paginate_media(response["next_url"], start_time, &block)
    end

    private

    def chrono_paginate_media(next_page_url, start_time)
      return unless next_page_url.present?

      response = pagination_media(next_page_url)
      raw_medias = reject_published_at_lt(time, response["medias"])
      yield raw_medias
      raw_medias.last && chrono_paginate_media(response["next_url"], start_time, &block)
    end

    def reject_published_at_lt(time, raw_medias)
      raw_medias.reject { |rw| rw["published_at"] < time }
    end

    def pagination_media(next_page_url)
      api_client.pagination_media(next_page_url)
    end

    def api_client
      Instagram::ApiClient.new
    end
  end
end
