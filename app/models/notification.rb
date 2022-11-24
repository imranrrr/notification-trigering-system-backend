class Notification < ApplicationRecord
    belongs_to :template, optional: true, foreign_key: :template_id
    belongs_to :endpoint, optional: true, foreign_key: :endpoint_id
    belongs_to :admin, optional: true, foreign_key: :admin_id
    belongs_to :user, optional: true, foreign_key: :user_id
    after_save :send_notifications

    def send_notifications
        template = Template.find_by(id: self.template_id)
        endpoint = Endpoint.find_by(id: self.endpoint_id)
        location = endpoint.location if endpoint.location.present?
        if location.present?
            updateXml = UpdateXmlFileService.new(location, template).update_xml_file_with_notification()
        end
    end
end
