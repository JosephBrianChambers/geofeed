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
        moment = MomentAdapter::Twitter.new(raw_tweet).moment
        PersistFetchedMoment.call(event, moment, moment.author) if moment.loc
      end
    end

    private

    def twitter_client
      ::Twitter::Client.new
    end
  end
end
