require "rails_helper"

RSpec.describe BubblesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/bubbles").to route_to("bubbles#index")
    end


    it "routes to #show" do
      expect(:get => "/bubbles/1").to route_to("bubbles#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/bubbles").to route_to("bubbles#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/bubbles/1").to route_to("bubbles#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/bubbles/1").to route_to("bubbles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/bubbles/1").to route_to("bubbles#destroy", :id => "1")
    end

  end
end
