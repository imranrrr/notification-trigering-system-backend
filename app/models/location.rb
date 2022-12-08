class Location < ApplicationRecord
    
    require 'nokogiri'

    has_many :endpoints
    belongs_to :web_signage, foreign_key: :web_signage_id
    belongs_to :company, optional: true
    belongs_to :user, foreign_key: :creator_id
    after_create :create_xml_file
    after_update :xml_file_update
    validates :name, presence: true

    enum creator_type: {
        default: 0,
        user: 1
    }
    

    def create_xml_file
        createXml = CreateXmlFileService.new(self).create_xml_file()
    end

    def xml_file_update
        updateXml = UpdateXmlFileService.new(self, nil).update_xml_file_with_location()
    end

end
