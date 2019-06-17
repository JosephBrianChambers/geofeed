require 'rails_helper'

RSpec.describe MomentParserAdapter::Tweet::MediaAttributes do
  subject { MomentParserAdapter::Tweet::MediaAttributes.new(raw_media) }

  describe "#url" do
    let(:raw_media) do
      path = Rails.root.join("spec", "fixtures", "raw_tweet_photo_media.json")
      JSON.parse(File.read(path))
    end

    it "returns url of first media" do
      expect(subject.url).to eq("https://pbs.twimg.com/media/DjclOUQU0AEKb6k.jpg")
    end
  end

  describe "#media_attributes" do
    let(:raw_media) do
      path = Rails.root.join("spec", "fixtures", "raw_tweet_photo_media.json")
      JSON.parse(File.read(path))
    end

    it "returns media attributes" do
      expect(subject.media_attributes).to eq({url: "https://pbs.twimg.com/media/DjclOUQU0AEKb6k.jpg" })
    end
  end
end

