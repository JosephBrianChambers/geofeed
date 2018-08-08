module FetchEventContent
  class Twitter
    attr_reader :event

    def self.call(event)
      self.new(event).call
    end

    def initialize(event)
      @event = event
    end

    def call
      twitter_client.geo_fence_tweets(event.geojson, start_time: 2.hours.ago, end_time: Time.now) do |raw_tweet|
        parser_adapter = MomentParserAdapter::Tweet.new(raw_tweet)

        next unless (lng_lat = parser_adapter.moment_attributes[:lng_lat]).present?
        next unless event.includes_lng_lat?(lng_lat)

        PersistFetchedMoment.call(event, parser_adapter)
      end
    end

    private

    def twitter_client
      ::Twitter::Client.new
    end
  end
end
