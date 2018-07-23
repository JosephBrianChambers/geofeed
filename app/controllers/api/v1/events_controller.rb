class Api::V1::EventsController < ApiBaseController
  def create
    event = Event.create!(event_params)
    json_response(event)
  end

  def show
    # TODO: serialize down meta data, total num moments ect..
    event = Event.find(params[:id])
    json_response(event)
  end

  def fetch_content
    event = Event.find(params[:id])
    # TODO: background job
    # FetchEventContent::Instagram.call(event)
    FetchEventContent::Twitter.call(event)
    head :ok
  end

  private

  def event_params
    whitelist = params.require(:event).permit!
    geojson_polygon = whitelist[:geo_fence].to_h

    {
      loc_fence_geo: RGeo::GeoJSON.decode(geojson_polygon, json_parser: :json, geo_factory: Event::FACTORY).geometry,
      start_time: Time.at(whitelist[:start_time].to_i),
      end_time: Time.at(whitelist[:end_time].to_i),
    }
  end
end
