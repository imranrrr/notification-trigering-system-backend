class UpdateXmlFileService
    require 'nokogiri'

    def initialize(location, template)
        @location = location
        @template = template
    end

    def update_xml_file
        filename = "public/xmlForLocations/xml_of_location_#{@location.id}.xml"
        if File.exist?(filename)
            file = File.read(filename)
            xml = Nokogiri::XML(file)
            # xml.at_css('node1').content =  @location.name
            xml.at_css('h3').content = @template.subject
            xml.at_css('p').content = @template.body
            File.write(filename, xml)
        else
            CreateXmlFileService.new(@location).create_xml_file()
            UpdateXmlFileService.new(@location, @template).update_xml_file()
        end
    end
end