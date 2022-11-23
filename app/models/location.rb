class Location < ApplicationRecord
    
    require 'nokogiri'

    has_many :endpoints
    belongs_to :web_signage, foreign_key: :web_signage_id
    after_update :xml_file_update
    validates :name, presence: true
    

    def xml_file_update
        updateXml = UpdateXmlFileService.new(self, nil).update_xml_file_with_location()
    end
end
