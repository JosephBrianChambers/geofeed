module MomentParserAdapter
  class Tweet
    class MomentAttributes
      attr_reader :raw_tweet

      def initialize(raw_tweet)
        @raw_tweet = raw_tweet
      end

      def moment_attributes
        {
          content_provider_id: content_provider_id,
          lng_lat: lng_lat,
          title: title,
          caption: caption,
          provider_id: provider_id,
        }.compact
      end

      def content_provider_id
        ContentProvider[:twitter].id
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

      def provider_id
        raw_tweet["id_str"]
      end
    end
  end
end
