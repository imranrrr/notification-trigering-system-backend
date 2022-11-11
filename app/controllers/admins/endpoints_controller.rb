class Admins::EndpointsController < ApplicationController
  before_action :set_endpoint, only: %i[ show update destroy ]

  def index
    begin
      endpoints = Endpoint.all
      render json: {
        endpoints: EndpointSerializer.new(endpoints).serializable_hash[:data].map{|data| data[:attributes]}
      }
    rescue => e
      render json: e.message
    end
  end

  def show
    begin
      render json: {
        endpoint: EndpointSerializer.new(@endpoint).serializable_hash[:data][:attributes]
      }
    rescue => e
      render json: e.message
    end
  end

  # POST /endpoints
  def create
    @endpoint = Endpoint.new(endpoint_params)
    begin
      if @endpoint.save!
         render json: {
         endpoint: EndpointSerializer.new(@endpoint).serializable_hash[:data][:attributes]
        }
      end
    rescue => e
      render json: e.message
    end
  end

  # PATCH/PUT /endpoints/1
  def update
    begin
      if @endpoint.update!(endpoint_params)
          render json: {
          endpoint: EndpointSerializer.new(@endpoint).serializable_hash[:data][:attributes]
        }
      end
    rescue => e
      render json: e.message
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
    rescue => e
      render json: e.message
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_endpoint
      begin
        @endpoint = Endpoint.find(params[:id])
      rescue => e
        render json: e.message
      end
    end

    # Only allow a list of trusted parameters through.
    def endpoint_params
      params.require(:endpoint).permit(:name, :description, :location_id, :endpoint_group_id, :destination_id, :admin_id)
    end
end
