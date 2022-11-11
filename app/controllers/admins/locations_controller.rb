class Admins::LocationsController < ApplicationController
  before_action :set_location, only: %i[ show update destroy ]

  def index
    begin
      locations = Location.all
      render json:{
        locations: LocationSerializer.new(locations).serializable_hash[:data].map{|data| data[:attributes]}
      }
    rescue => e
      render json: e.message
    end
  end

  def show
    begin
      render json: {
          location: LocationSerializer.new(@location).serializable_hash[:data][:attributes]
        }
    rescue => e
      render json: e.message
    end
  end

  def create
    location = Location.new(location_params)
    begin
      if location.save!
        render json: {
          location: LocationSerializer.new(location).serializable_hash[:data][:attributes]
      }
    end
    rescue => e
      render json: e.message
    end
  end

  def update
    begin
      if @location.update!(location_params)
        render json: {
          location: LocationSerializer.new(@location).serializable_hash[:data][:attributes]
        }
      end
    rescue => e
      render json: e.message
    end
  end

  def destroy
    begin
      render json: {
          status: "you just destroyed! location",
          location: @location
        }
      @location.destroy
    rescue => e 
      render json: e.message
    end
  end

  private
    def set_location
      begin  
        @location = Location.find(params[:id])
      rescue => e
        render json: e.message
      end
    end

    def location_params
      params.require(:location).permit(:name, :web_signage_id, :description, :admin_id)
    end
end
