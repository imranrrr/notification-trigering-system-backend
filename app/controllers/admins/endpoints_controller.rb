class Admins::EndpointsController < ApplicationController
  before_action :set_endpoint, only: %i[ show update destroy ]

  # GET /endpoints
  def index
    endpoints = Endpoint.all
    render json: {
      endpoints: EndpointSerializer.new(endpoints).serializable_hash[:data].map{|data| data[:attributes]}
    }
  end

  # GET /endpoints/1
  def show
    render json: {
      endpoint: EndpointSerializer.new(@endpoint).serializable_hash[:data][:attributes]
    }
  end

  # POST /endpoints
  def create
    @endpoint = Endpoint.new(endpoint_params)

    if @endpoint.save
      render json: {
        endpoint: EndpointSerializer.new(@endpoint).serializable_hash[:data][:attributes]
      }
    else
      render json: @endpoint.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /endpoints/1
  def update
    if @endpoint.update(endpoint_params)
        render json: {
        endpoint: EndpointSerializer.new(@endpoint).serializable_hash[:data][:attributes]
      }
    else
      render json: @endpoint.errors, status: :unprocessable_entity
    end
  end

  # DELETE /endpoints/1
  def destroy
    begin
      render json: {
          message: "you just destroyed! Endpoint",
          endpoint: @endpoint
        }
      @endpoint.destroy
    rescue 
      @endpoint.errors
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_endpoint
      @endpoint = Endpoint.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def endpoint_params
      params.require(:endpoint).permit(:name, :description, :location_id, :endpoint_group_id, :destination_id, :admin_id)
    end
end
