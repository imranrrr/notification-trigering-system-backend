class Admins::LocationsController < ApplicationController
  before_action :set_location, only: %i[ show update destroy ]

  # GET /locations
  def index
    locations = Location.all

    render json:{
      locations: LocationSerializer.new(locations).serializable_hash[:data].map{|data| data[:attributes]}
    }
  end

  # GET /locations/1
  def show
    render json: {
        location: LocationSerializer.new(@location).serializable_hash[:data][:attributes]
      }
  end

  # POST /locations
  def create
    location = Location.new(location_params)

    if location.save
      render json: {
        location: LocationSerializer.new(location).serializable_hash[:data][:attributes]
    }
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /locations/1
  def update
    if @location.update(location_params)
      render json: {
        location: LocationSerializer.new(@location).serializable_hash[:data][:attributes]
      }
    else
      render json: @location.errors, status: :unprocessable_entity
    end
  end

  # DELETE /locations/1
  def destroy
    render json: {
        status: "you just destroyed! location",
        location: @location
      }
    @location.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:name, :web_signage_id, :description, :admin_id)
    end
end
