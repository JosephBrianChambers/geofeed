class Api::V1::MomentsController < ApiBaseController
  def show
    # TODO: serialize down meta data, total num moments ect..
    event = Moment.find(params[:id])
    json_response(event)
  end
end
