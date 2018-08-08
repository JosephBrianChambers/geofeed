module MomentParserAdapter
  class Tweet
    attr_reader :raw_tweet

    def initialize(raw_tweet)
      @raw_tweet = raw_tweet
    end

    def moment_attributes
      MomentParserAdapter::Tweet::MomentAttributes.new(raw_tweet).moment_attributes
    end

    def author_attributes
      MomentParserAdapter::Tweet::AuthorAttributes.new(raw_tweet).author_attributes
    end

    def medias_attributes
      raw_tweet.dig("entities", "media").to_a.map do |raw_media|
        MomentParserAdapter::Tweet::MediaAttributes.new(raw_media).media_attributes
      end
    end
  end
end
