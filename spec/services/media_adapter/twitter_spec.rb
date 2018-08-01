require 'rails_helper'

RSpec.describe MediaAdapter::Twitter do
  subject { MediaAdapter::Twitter.new(raw_media) }

  describe "#url" do
    let(:raw_media) do
      path = Rails.root.join("spec", "fixtures", "raw_tweet_photo_media.json")
      JSON.parse(File.read(path))
    end

    it "returns url of first media" do
      expect(subject.url).to eq("https://pbs.twimg.com/media/DjclOUQU0AEKb6k.jpg")
    end
  end

  describe "#media" do
    let(:raw_media) do
      path = Rails.root.join("spec", "fixtures", "raw_tweet_photo_media.json")
      JSON.parse(File.read(path))
    end

    it "returns media" do
      expect(subject.media).to be_a(Media)
    end
  end
end

