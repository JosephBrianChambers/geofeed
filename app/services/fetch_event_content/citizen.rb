module FetchEventContent
  class Citizen
    attr_reader :event

    def self.call(event)
      self.new(event).call
    end

    def initialize(event)
      @event = event
    end

    def call
      citizen_client.geo_fence_alerts(event, start_time: 2.hours.ago, end_time: Time.now) do |raw_alert|
        parser_adapter = MomentParserAdapter::CitizenAlert.new(raw_alert)

        next unless (lng_lat = parser_adapter.moment_attributes[:lng_lat]).present?
        next unless event.includes_lng_lat?(lng_lat)

        PersistParsedMomentResponse.call(event, parser_adapter)
      end
    end

    private

    def citizen_client
      ::Citizen::Client.new
    end
  end
end
