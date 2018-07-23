module MomentAdapter
  class Twitter
    attr_reader :raw_tweet

    def initialize(raw_tweet)
      @raw_tweet = raw_tweet
    end

    def moment
      moment = Moment.new(moment_attributes)
    end

    def moment_attributes
      {
        content_provider: content_provider,
        lng_lat: lng_lat,
        title: title,
        caption: caption,
        media: media,
        author: author,
        provider_id: provider_id,
      }.compact
    end

    def content_provider
      ContentProvider[:twitter]
    end

    def title
      nil
    end

    def caption
      raw_tweet["text"]
    end

    def lng_lat
      raw_tweet.dig("coordinates", "coordinates")
    end

    def author
      AuthorAdapter::Twitter.new(raw_tweet).author
    end

    def media
      # MediaAdapter::Twitter.new(raw_tweet).media
    end

    def provider_id
      raw_tweet["id_str"]
    end
  end
end
