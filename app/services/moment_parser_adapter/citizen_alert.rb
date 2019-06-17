module MomentParserAdapter
  class CitizenAlert
    attr_reader :raw_alert

    def initialize(raw_alert)
      @raw_alert = raw_alert
    end

    def moment_attributes
      MomentParserAdapter::CitizenAlert::MomentAttributes.new(raw_alert).moment_attributes
    end

    def author_attributes
      MomentParserAdapter::CitizenAlert::AuthorAttributes.new(raw_alert).author_attributes
    end

    def medias_attributes
      raw_alert.dig("entities", "media").to_a.map do |raw_media|
        MomentParserAdapter::CitizenAlert::MediaAttributes.new(raw_media).media_attributes
      end
    end
  end
end
