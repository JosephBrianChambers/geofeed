module MomentParserAdapter
  class CitizenAlert
    class MomentAttributes
      attr_reader :raw_alert

      def initialize(raw_alert)
        @raw_alert = raw_alert
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
        ContentProvider[:citizen].id
      end

      def title
        nil
      end

      def caption
        items = [raw_alert["title"]] + updates.map { |_, u| u["text"] }
        items.compact.join(" ")
      end

      def lng_lat
        raw_alert["ll"]&.reverse
      end

      def provider_id
        raw_alert["id"]
      end

      private

      def updates
        raw_alert["updates"].to_a
      end
    end
  end
end
