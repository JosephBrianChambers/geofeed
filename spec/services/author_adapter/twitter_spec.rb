require 'rails_helper'

RSpec.describe AuthorAdapter::Twitter do
  fixtures :content_providers

  subject { AuthorAdapter::Twitter.new(raw_tweet) }

  describe "#name" do
    let(:raw_tweet) do
      path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
      JSON.parse(File.read(path))
    end

    it "returns name" do
      expect(subject.name).to eq("SF Weather, Warnings")
    end
  end

  describe "#email" do
    let(:raw_tweet) do
      path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
      JSON.parse(File.read(path))
    end

    it "returns nil" do
      expect(subject.email).to eq(nil)
    end
  end

  describe "#provider_id" do
    let(:raw_tweet) do
      path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
      JSON.parse(File.read(path))
    end

    it "returns provider id" do
      expect(subject.provider_id).to eq("585167005")
    end
  end

  describe "#avatar_url" do
    let(:raw_tweet) do
      path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
      JSON.parse(File.read(path))
    end

    it "returns avatar url" do
      expected_result = "https://pbs.twimg.com/profile_images/1019745299747635204/mARK68aZ_normal.jpg"

      expect(subject.avatar_url).to eq(expected_result)
    end
  end

  describe "#author" do
    let(:raw_tweet) do
      path = Rails.root.join("spec", "fixtures", "raw_geo_tweet.json")
      JSON.parse(File.read(path))
    end

    it "returns valid author" do
      expect(subject.author.valid?).to eq(true)
    end
  end
end

