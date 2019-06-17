module MomentParserAdapter
  class CitizenAlert
    class AuthorAttributes
      attr_reader :raw_alert

      def initialize(raw_alert)
        @raw_alert = raw_alert
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
        "Citizen"
      end

      def email
        nil
      end

      def avatar_url
        "https://i.vimeocdn.com/portrait/17898182_150x150.webp"
      end

      def provider_id
        "-1"
      end
    end
  end
end
