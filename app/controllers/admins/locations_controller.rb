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
        xml = Nokogiri::XML::Builder.new { |xml|
          xml.body do
            xml.node1 location.name
            xml.node2 location.description 
            xml.node3
          end
        }.to_xml
      Dir.mkdir("public/xmlForLocations") unless Dir.exists?("public/xmlForLocations")
      newXmlFile = File.new("public/xmlForLocations/xml_of_location_#{location.id}.xml", "w")
      newXmlFile.puts(xml)
      newXmlFile.close
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
         file = File.read(filename)
         xml = Nokogiri::XML(file)
         xml.at_css('node1').content =  @location.name
         xml.at_css('node2').content = ""
         File.write(filename, xml)

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
