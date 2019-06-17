module MomentParserAdapter
  class Tweet
    class AuthorAttributes
      attr_reader :raw_tweet

      def initialize(raw_tweet)
        @raw_tweet = raw_tweet
      end

      def author_attributes
        {
          content_provider: ContentProvider[:twitter],
          provider_id: provider_id,
          avatar_url: avatar_url,
          name: name,
          email: email,
        }
      end

      def name
        raw_tweet.dig("user", "name")
      end

      def email
        nil
      end

      def avatar_url
        raw_tweet.dig("user", "profile_image_url_https")
      end

      def provider_id
        raw_tweet.dig("user", "id_str")
      end
    end
  end
end
