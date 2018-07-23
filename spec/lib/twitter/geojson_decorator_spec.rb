require 'rails_helper'

RSpec.describe Twitter::GeojsonDecorator do
  subject { Twitter::GeojsonDecorator.new(geojson_polygon) }

  let(:geojson_polygon) { build(:geojson_polygon, :sf_vanness) }

  describe "#centroid_lat" do
    it "returns centroid latitude" do
      expect(subject.centroid_lat).to eq(37.783672270721034)
    end
  end

  describe "#centroid_lng" do
    it "returns centroid longitude" do
      expect(subject.centroid_lng).to eq(-122.4209976196289)
    end
  end

  describe "#radius" do
    it "returns instagram api location radius" do
      expect(subject.radius).to eq(1039.950459941256)
    end
  end
end
