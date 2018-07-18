module FetchEventContent
  class Instagram
    attr_reader :event

    def initialize(event)
      @event = event
    end

    def call
      instagram_client.geo_fence_media(geojson_polygon, start_time: event.start_time, end_time: event.end_time) do |raw_medias|
        raw_medias.each do |raw_media|
          moment = MomentAdapter::Instagram.new(raw_media).moment
          moment.save!
        end
      end
    end

    private

    def instagram_client
      Instagram::Client.new
    end
  end
end
