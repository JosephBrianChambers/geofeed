module MomentParserAdapter
  class Tweet
    class MediaAttributes
      attr_reader :raw_media

      def initialize(raw_media)
        @raw_media = raw_media
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
        raw_media["media_url_https"]
      end
    end
  end
end
