class Admins::DestinationsController < ApplicationController
  before_action :set_destination, only: %i[ show update destroy ]

  # GET /destinations
  def index
    begin
      destinations = Destination.all
      render json: {
        destinations: DestinationSerializer.new(destinations).serializable_hash[:data].map{|data| data[:attributes]}
        }
    rescue
      render json: "Something Went Wrong!"
    end
  end

  # GET /destinations/1
  def show
    begin
      render json: {
        destination: DestinationSerializer.new(@destination).serializable_hash[:data][:attributes]
      }
    rescue
      render json: "Something Went Wrong!"
    end
  end

  # POST /destinations
  def create
    begin
      destination = Destination.new(destination_params)
      if destination.save!
        render json: {
          status: true,
          destination: DestinationSerializer.new(destination).serializable_hash[:data][:attributes]
        }
      end
    rescue
        render json: {status: :unprocessable_entity}
    end
  end

  # PATCH/PUT /destinations/1
  def update
    begin 
      @destination.update(destination_params)
        render json: {
          status: true,
          destination: DestinationSerializer.new(@destination).serializable_hash[:data][:attributes]
        }
    rescue
      render json: {status: :unprocessable_entity}
    end
  end

  # DELETE /destinations/1
  def destroy
    begin
      render json: {
          status: true,
          message: "you just deleted! Destination",
          destination: @destination
        }
      @destination.destroy
    rescue
      render json: {status: :unprocessable_entity}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_destination
      begin
        @destination = Destination.find(params[:id])
      rescue
        "Something Went Wrong!"
      end
    end

    # Only allow a list of trusted parameters through.
    def destination_params
      params.require(:destination).permit(:destination_type, :resource_url, :network_distribution_id, :admin_id)
    end
end
