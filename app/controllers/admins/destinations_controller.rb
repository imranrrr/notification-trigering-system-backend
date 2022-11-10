class Admins::DestinationsController < ApplicationController
  before_action :set_destination, only: %i[ show update destroy ]

  # GET /destinations
  def index
    destinations = Destination.all
    render json: {
      destinations: DestinationSerializer.new(destinations).serializable_hash[:data].map{|data| data[:attributes]}
    }
  end

  # GET /destinations/1
  def show
    render json: {
      destination: DestinationSerializer.new(@destination).serializable_hash[:data][:attributes]
    }
  end

  # POST /destinations
  def create
    destination = Destination.new(destination_params)

    if destination.save
      render json: {
        status: true,
        destination: DestinationSerializer.new(destination).serializable_hash[:data][:attributes]
      }
    else
      render json: destination.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /destinations/1
  def update
    if @destination.update(destination_params)
      render json: {
        status: true,
        destination: DestinationSerializer.new(@destination).serializable_hash[:data][:attributes]
      }
    else
      render json: @destination.errors, status: :unprocessable_entity
    end
  end

  # DELETE /destinations/1
  def destroy
    render json: {
        status: true,
        message: "you just deleted! Destination",
        destination: @destination
      }
    @destination.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_destination
      @destination = Destination.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def destination_params
      params.require(:destination).permit(:destination_type, :resource_url, :network_distribution_id, :admin_id)
    end
end
