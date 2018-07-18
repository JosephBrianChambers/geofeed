require 'rails_helper'

RSpec.describe Instagram::ApiClient do
  subject { Instagram::ApiClient.new }

  describe "#locations_search" do
    let(:lat) { 37.783672270721034 }
    let(:lng) { -122.4209976196289 }
    let(:distance) { 500 } # meters

    it "returns raw locations" do
      expected_result = {"data"=>[{"id"=>"44961364", "name"=>"San Francisco, California", "latitude"=>37.7793, "longitude"=>-122.419}, {"id"=>"1620031454964122", "name"=>"Hinata", "latitude"=>37.78324, "longitude"=>-122.42048}, {"id"=>"44961364", "name"=>"San Francisco, California", "latitude"=>37.7793, "longitude"=>-122.419}, {"id"=>"5348828", "name"=>"Lamborghini San Francisco", "latitude"=>37.78407, "longitude"=>-122.42129}, {"id"=>"368022523536058", "name"=>"City Halls", "latitude"=>37.77929, "longitude"=>-122.41922}, {"id"=>"15707329", "name"=>"Civic Center", "latitude"=>37.779471064266, "longitude"=>-122.41715141625}, {"id"=>"236385752", "name"=>"Fillmore District, San Francisco", "latitude"=>37.790147, "longitude"=>-122.433081}, {"id"=>"901313416663184", "name"=>"Tesla SF", "latitude"=>37.78443, "longitude"=>-122.42166}, {"id"=>"1726022884306777", "name"=>"Downtown San Francisco City", "latitude"=>37.77929, "longitude"=>-122.41922}, {"id"=>"581081432", "name"=>"White Chapel", "latitude"=>35.0494, "longitude"=>-90.1172}, {"id"=>"867730534", "name"=>"AMC Van Ness 14", "latitude"=>37.785045583605, "longitude"=>-122.42071842828}, {"id"=>"333055057173922", "name"=>"Larkin Street Youth Service", "latitude"=>37.78375, "longitude"=>-122.42047}, {"id"=>"211881545", "name"=>"Twin Peaks (San Francisco)", "latitude"=>37.751586, "longitude"=>-122.447722}, {"id"=>"213737803", "name"=>"Tenderloin, San Francisco", "latitude"=>37.788287940559, "longitude"=>-122.41600722432}, {"id"=>"200092467200414", "name"=>"Mr. Holmes Bakehouse", "latitude"=>37.7876654, "longitude"=>-122.4182267}, {"id"=>"924622326", "name"=>"San Francisco City Hall", "latitude"=>37.79094, "longitude"=>-122.39906}, {"id"=>"3001795", "name"=>"Union Square, San Francisco", "latitude"=>37.787069070793, "longitude"=>-122.40759938952}, {"id"=>"280800296", "name"=>"San Francisco Pride", "latitude"=>37.7709618, "longitude"=>-122.424202}, {"id"=>"283804215390455", "name"=>"Palace of Fine Arts Theatre", "latitude"=>37.802125239059, "longitude"=>-122.44825058286}, {"id"=>"1630", "name"=>"Brenda's French Soul Food", "latitude"=>37.7829, "longitude"=>-122.41887}], "meta"=>{"code"=>200}}

      VCR.use_cassette('instagram_locations_search') do
        expect(subject.locations_search(lat: lat, lng: lng, distance: distance)).to eq(expected_result)
      end
    end
  end

  describe "#location_media" do
    let(:location_id) { 44961364 }

    it "returns raw_media" do
      expected_result = {
        "pagination" => {},
        "data" => [],
        "meta" => {
          "code" => 200
        }
      }

      VCR.use_cassette('instagram_location_media') do
        expect(subject.location_media(location_id: location_id)).to eq(expected_result)
      end
    end
  end
end
