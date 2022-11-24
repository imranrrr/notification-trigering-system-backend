class UpdateXmlFileService
    require 'nokogiri'

    def initialize(location, template)
        @location = location
        @template = template
    end

    def update_xml_file_with_notification
        begin
        filename = "public/xmlForLocations/xml_of_location_#{@location.id}.xml"
        if File.exist?(filename)
            file = File.read(filename)
            xml = Nokogiri::XML(file)
            xml.at_css('h3').content = @template.subject
            xml.at_css('p').content = @template.body
            File.write(filename, xml)
        else
            CreateXmlFileService.new(@location).create_xml_file()
            UpdateXmlFileService.new(@location, @template).update_xml_file_with_notification()
        end
        rescue Exception
            raise ArgumentError, "Something went wrong while updating xml file! :(, Either Location has not found or Template has not found!"
        end
    end

    def update_xml_file_with_location
        filename = "public/xmlForLocations/xml_of_location_#{@location.id}.xml"
         if File.exist?(filename)
          file = File.read(filename)
          xml = Nokogiri::XML(file)
          xml.at_css('h1').content =  @location.name
          File.write(filename, xml)
         end
    end
end