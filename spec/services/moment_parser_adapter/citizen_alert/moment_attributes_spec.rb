require 'rails_helper'

RSpec.describe MomentParserAdapter::CitizenAlert::MomentAttributes do
  fixtures :content_providers

  subject { MomentParserAdapter::CitizenAlert::MomentAttributes.new(raw_alert) }

  describe "#lng_lat" do
    describe "when geo tweet" do
    let(:raw_alert) do
      path = Rails.root.join("spec", "fixtures", "citizen_raw_alert_geo.json")
      JSON.parse(File.read(path))
    end

      it "returns coordintates" do
        expect(subject.lng_lat).to eq([-122.42, 37.78])
      end
    end
  end

  describe "#caption" do
    let(:raw_alert) do
      path = Rails.root.join("spec", "fixtures", "citizen_raw_alert_geo.json")
      JSON.parse(File.read(path))
    end

    it "returns caption" do
      expected_result = "Cat Stuck on Utility Pole Incident reported at 2505 Olympic Blvd. Firefighters at the scene report that a cat is stuck on a utility pole in a back yard. PG&E has been notified. San Mateo Animal Control is on the way. Firefighters have been unable to locate an owner, and the cat has no tags."
      expect(subject.caption).to eq(expected_result)
    end
  end

  describe "#title" do
    let(:raw_alert) do
      path = Rails.root.join("spec", "fixtures", "citizen_raw_alert_geo.json")
      JSON.parse(File.read(path))
    end

    it "returns nil" do
      expect(subject.title).to eq(nil)
    end
  end

  describe "#content_provider_id" do
    let(:raw_alert) do
      path = Rails.root.join("spec", "fixtures", "citizen_raw_alert_geo.json")
      JSON.parse(File.read(path))
    end

    it "returns content_provider" do
      expect(ContentProvider.find(subject.content_provider_id).name).to eq("Citizen")
    end
  end

  describe "#provider_id" do
    let(:raw_alert) do
      path = Rails.root.join("spec", "fixtures", "citizen_raw_alert_geo.json")
      JSON.parse(File.read(path))
    end

    it "returns provider id" do
      expect(subject.provider_id).to eq("-LLQakYx64DKb2UR6jeK")
    end
  end

  describe "#moment_attributes" do
    let(:raw_alert) do
      path = Rails.root.join("spec", "fixtures", "citizen_raw_alert_geo.json")
      JSON.parse(File.read(path))
    end

    it "returns moment attributes" do
      expected_result = {
        :content_provider_id => ContentProvider.where(code: "citizen").first.id,
        :lng_lat => [-122.42, 37.78],
        :caption => "Cat Stuck on Utility Pole Incident reported at 2505 Olympic Blvd. Firefighters at the scene report that a cat is stuck on a utility pole in a back yard. PG&E has been notified. San Mateo Animal Control is on the way. Firefighters have been unable to locate an owner, and the cat has no tags.",
        :provider_id => "-LLQakYx64DKb2UR6jeK"
      }

      expect(subject.moment_attributes).to eq(expected_result)
    end
  end
end

