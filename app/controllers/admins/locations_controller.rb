class Admins::LocationsController < ApplicationController
  before_action :set_location, only: %i[ show update destroy ]

  require 'nokogiri'

  def index
    begin
      locations = Location.all
      render json:{
        locations: LocationSerializer.new(locations).serializable_hash[:data].map{|data| data[:attributes]}
      }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def show
    begin
      render json: {
          location: LocationSerializer.new(@location).serializable_hash[:data][:attributes]
        }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def create
    location = Location.new(location_params)
    begin
      if location.save!
        createXml = CreateXmlFileService.new(location).create_xml_file()
        render json: {
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
          #... For Testing we Are updating xml file here ...

         filename = "public/xmlForLocations/xml_of_location_#{@location.id}.xml"
         if File.exist?(filename)
          file = File.read(filename)
          xml = Nokogiri::XML(file)
          xml.at_css('h1').content =  @location.name
          File.write(filename, xml)
        end
            #... For Testing we Are updating xml file here ...
        render json: {
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
          status: "you just destroyed! location",
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
      params.require(:location).permit(:name, :web_signage_id, :description, :admin_id)
    end
end
