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
        moment.author = AuthorAdapter::Twitter.new(raw_tweet).author
        PersistFetchedMoment.call(event, moment)
      end
    end

    private

    def twitter_client
      ::Twitter::Client.new
    end
  end
end
