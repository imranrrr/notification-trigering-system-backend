class Notification < ApplicationRecord

    def self.manage_notifications(notification_params)
        template = Template.find_by(id: notification_params[:template_id])
        endpoint_ids = notification_params[:endpoint_ids]
        notifications = []
        endpoints = []
        locations = []
        endpoint_ids.each do |endpoint_id|
            notifications << Notification.create!(template_id: notification_params[:template_id], endpoint_id: endpoint_id, user_id: notification_params[:user_id], admin_id: notification_params[:admin_id])
            e_point = Endpoint.find_by(id: endpoint_id)
            if e_point.present?
                endpoints << e_point
            end
        end
        endpoints.each do |endpoint|
            if endpoint.location.present?
                locations << endpoint.location
            end
        end
        locations.each do |location|
            updateXml = UpdateXmlFileService.new(location, template).update_xml_file()
        end
    end
end
