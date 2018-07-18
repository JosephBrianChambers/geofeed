class Api::V1::EventsController < ApiBaseController
  def create
    event = Event.create!(event_params)
    json_response(event)
  end

  def show
    event = Event.find(params[:id])
    json_response(event)
  end

  def fetch_content
    event = Event.find(params[:id])
    FetchEventContent::Instagram.call(event)
    FetchEventContent::Twitter.call(event)
  end

  private

  def event_params
    whitelist = params.require(:event).permit!

    {
      loc_fence_geo: RGeo::GeoJSON.decode(whitelist[:geo_fence].to_h, json_parser: :json, geo_factory: Event::FACTORY).geometry,
      start_time: Time.at(whitelist[:start_time].to_i),
      end_time: Time.at(whitelist[:end_time].to_i),
    }
  end
end
