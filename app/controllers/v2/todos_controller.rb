class V2::TodosController < ApiBaseController
  def index
    @todos = current_user.todos.includes(:items).paginate(page: params[:page], per_page: 20)
    json_response(@todos)
  end
end
