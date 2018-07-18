module FetchEventContent
  class Twitter
    attr_reader :event

    def initialize(event)
      @event = event
    end

    def call
      twitter_client.geo_fence_tweets(geojson_polygon, start_time: event.start_time, end_time: event.end_time) do |raw_tweets|
        raw_tweets.each do |raw_tweet|
          moment = MomentAdapter::Twitter.new(raw_tweet).moment
          moment.save!
        end
      end
    end

    private

    def twitter_client
      Twitter::Client.new
    end
  end
end
