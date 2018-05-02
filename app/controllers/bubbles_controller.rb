class BubblesController < ApplicationController
  before_action :set_bubble, only: [:show, :update, :destroy]

  # GET /bubbles
  def index
    @bubbles = Bubble.all

    render json: @bubbles
  end

  # GET /bubbles/1
  def show
    render json: @bubble
  end

  # POST /bubbles
  def create
    @bubble = Bubble.new(bubble_params)

    if @bubble.save
      render json: @bubble, status: :created, location: @bubble
    else
      render json: @bubble.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bubbles/1
  def update
    if @bubble.update(bubble_params)
      render json: @bubble
    else
      render json: @bubble.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bubbles/1
  def destroy
    @bubble.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bubble
      @bubble = Bubble.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bubble_params
      params.fetch(:bubble, {})
    end
end
