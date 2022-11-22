class CreateXmlFileService
    require 'nokogiri'

    def initialize(location)
        @location = location
        @WebSignage = @location.web_signage
    end

    def create_xml_file
        xml = Nokogiri::XML::Builder.new { |xml|
          xml.body do
            xml.h1(@location.name, 'style' => "font-size: #{@WebSignage.landscape_title_width}; font-weight: bold" )
            xml.h3['style'] = "width: #{@WebSignage.landscape_title_width}" 
            xml.p['style'] = "margin-top: #{@WebSignage.landscape_title_width}"
          end
        }.to_xml
        Dir.mkdir("public/xmlForLocations") unless Dir.exists?("public/xmlForLocations")
        newXmlFile = File.new("public/xmlForLocations/xml_of_location_#{@location.id}.xml", "w")
        newXmlFile.puts(xml)
        newXmlFile.close
    end
end