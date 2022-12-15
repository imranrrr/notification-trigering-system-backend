class Admins::LocationsController < ApplicationController
  before_action :set_location, only: %i[ show update destroy ]
  before_action :authenticate_admin!

  def index
    begin
      locations = Location.all
      render json:{
        status: 200,
        locations: LocationSerializer.new(locations).serializable_hash[:data].map{|data| data[:attributes]}
      }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def show
    begin
      render json: {
          status: 200,  
          location: LocationSerializer.new(@location).serializable_hash[:data][:attributes]
        }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def create
    location = Location.new(location_params)
    location.admin_id = current_admin.id; location.creator_type = 0
    begin
      if location.save!
        render json: {
          status: 200,
          location: LocationSerializer.new(location).serializable_hash[:data][:attributes]
        }
      end
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def update
    begin
      if @location.update!(location_params)
        render json: {
          status: 200,
          location: LocationSerializer.new(@location).serializable_hash[:data][:attributes]
        }
      end
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def destroy
    begin
      render json: {
          status: 200,
          location: @location
        }
      @location.destroy
      filename = "public/xmlForLocations/xml_of_location_#{@location.id}.xml"
      File.delete(filename) if File.exist?(filename)
    rescue => e 
      render json: {status: 500, message: e.message}
    end
  end

  private
    def set_location
      begin  
        @location = Location.find(params[:id])
      rescue => e
        render json: {status: 500, message: e.message}
      end
    end

    def location_params
      params.require(:location).permit(:name, :web_signage_id, :description)
    end
end
