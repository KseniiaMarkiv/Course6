class StatesController < ApplicationController
  before_action :set_state, only: [:show, :update, :destroy]

  # GET /states
  # GET /states.json
  def index
    @states = State.all

    # render json: @states
  end

  # GET /states/1
  # GET /states/1.json
  def show
    # render json: @state
  end

  # POST /states
  # POST /states.json
  def create
    @state = State.new(state_params)

    if @state.save
      # render json: @state, status: :created, location: @state
      render :show, status: :created, location: @state
    else
      render json: @state.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /states/1
  # PATCH/PUT /states/1.json
  def update
    if @state.update(state_params)
      head :no_content
    else
      render json: @state.errors, status: :unprocessable_entity
    end
  end

  # DELETE /states/1
  # DELETE /states/1.json
  def destroy
    @state.destroy

    head :no_content
  end

  private

    def set_state
      @state = State.find(params[:id])
    end

    def state_params
      params.require(:state).permit(:name)
    end
end
