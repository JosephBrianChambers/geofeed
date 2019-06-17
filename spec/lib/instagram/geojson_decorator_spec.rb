require 'rails_helper'

RSpec.describe Instagram::GeojsonDecorator do
  subject { Instagram::GeojsonDecorator.new(geojson_polygon) }

  let(:geojson_polygon) { build(:geojson_polygon, :sf) }

  describe "#centroid_lat" do
    it "returns centroid latitude" do
      expect(subject.centroid_lat).to eq(37.753615462062704)
    end
  end

  describe "#centroid_lng" do
    it "returns centroid longitude" do
      expect(subject.centroid_lng).to eq(-122.43747711181643)
    end
  end

  describe "#radius" do
    it "returns instagram api location radius" do
      expect(subject.radius).to eq(11345.554519829126)
    end
  end
end
