class Location < ApplicationRecord
    
    require 'nokogiri'

    has_many :endpoints
    belongs_to :web_signage, foreign_key: :web_signage_id, optional: true
    after_update :xml_file_update
    validates :name, presence: true
    

    def xml_file_update
        filename = "public/xmlForLocations/xml_of_location_#{self.id}.xml"
         if File.exist?(filename)
          file = File.read(filename)
          xml = Nokogiri::XML(file)
          xml.at_css('h1').content =  self.name
          File.write(filename, xml)
         end
    end
end
