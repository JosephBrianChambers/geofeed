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

        # TODO: possibily assign author & media associations in moment adapter
        moment.author = AuthorAdapter::Twitter.new(raw_tweet).author
        save_records(moment) unless moment.loc.blank?
      end
    end

    # TODO: extact this to shared service object
    def save_records(moment)
      save_author(moment.author)
      save_moment(moment)
      moment.events << event
    end

    private

    def save_moment(moment)
      moment.save!
    rescue ActiveRecord::RecordInvalid => e
      return true if !!(e.message =~ /#{Moment::PROVIDER_DUPLICATE_MESSAGE}/)

      raise e
    end

    def save_author(author)
      author.save!
    rescue ActiveRecord::RecordInvalid => e
      return true if !!(e.message =~ /#{Author::PROVIDER_DUPLICATE_MESSAGE}/)

      raise e
    end

    def twitter_client
      ::Twitter::Client.new
    end
  end
end
