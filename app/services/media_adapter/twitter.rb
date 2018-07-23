module MediaAdapter
  class Twitter
    attr_reader :raw_tweet

    def initialize(raw_tweet)
      @raw_tweet = raw_tweet
    end

    def media
      Media.new(media_attributes)
    end

    def media_attributes
      {
        url: url
      }
    end

    def url
      raw_tweet.dig("")
    end
  end
end
