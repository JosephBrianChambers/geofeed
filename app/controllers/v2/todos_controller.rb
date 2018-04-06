class V2::TodosController < ApiBaseController
  def index
    json_response({ message: 'Hello there'})
  end
end
