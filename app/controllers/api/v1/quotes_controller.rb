class Api::V1::QuotesController < ApiBaseController
  skip_before_action :authorize_request
  before_action :set_quote, only: [:show]

  def show
    json_response(@quote)
  end

  def set_quote
    @quote = Quote.find_by!(id: params[:id])
  end
end
