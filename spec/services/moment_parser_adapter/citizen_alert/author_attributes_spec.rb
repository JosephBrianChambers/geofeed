require 'rails_helper'

RSpec.describe MomentParserAdapter::CitizenAlert::AuthorAttributes do
  fixtures :content_providers

  subject { MomentParserAdapter::CitizenAlert::AuthorAttributes.new(raw_alert) }

  describe "#name" do
    let(:raw_alert) do
      path = Rails.root.join("spec", "fixtures", "citizen_raw_alert_geo.json")
      JSON.parse(File.read(path))
    end

    it "returns name" do
      expect(subject.name).to eq("Citizen")
    end
  end

  describe "#email" do
    let(:raw_alert) do
      path = Rails.root.join("spec", "fixtures", "citizen_raw_alert_geo.json")
      JSON.parse(File.read(path))
    end

    it "returns nil" do
      expect(subject.email).to eq(nil)
    end
  end

  describe "#provider_id" do
    let(:raw_alert) do
      path = Rails.root.join("spec", "fixtures", "citizen_raw_alert_geo.json")
      JSON.parse(File.read(path))
    end

    it "returns provider id" do
      expect(subject.provider_id).to eq("-1")
    end
  end

  describe "#avatar_url" do
    let(:raw_alert) do
      path = Rails.root.join("spec", "fixtures", "citizen_raw_alert_geo.json")
      JSON.parse(File.read(path))
    end

    it "returns avatar url" do
      expected_result = "https://i.vimeocdn.com/portrait/17898182_150x150.webp"

      expect(subject.avatar_url).to eq(expected_result)
    end
  end

  describe "#author_attributes" do
    let(:raw_alert) do
      path = Rails.root.join("spec", "fixtures", "citizen_raw_alert_geo.json")
      JSON.parse(File.read(path))
    end

    it "returns valid author attributes" do
      expect(Author.new(subject.author_attributes).valid?).to eq(true)
    end
  end
end

