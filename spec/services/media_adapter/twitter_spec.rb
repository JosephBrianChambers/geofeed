require 'rails_helper'

RSpec.describe MediaAdapter::Twitter do
  subject { MediaAdapter::Twitter.new(raw_tweet) }

  describe "#url" do
    let(:raw_tweet) do
      path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
      JSON.parse(File.read(path))
    end

    it "returns url" do
      expect(subject.url).to eq("")
    end
  end

  describe "#media" do
    let(:raw_tweet) do
      path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
      JSON.parse(File.read(path))
    end

    it "returns valid media" do
      expect(subject.media.valid?).to eq(true)
    end
  end
end

