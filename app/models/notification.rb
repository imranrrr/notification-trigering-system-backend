class Notification < ApplicationRecord
    after_save :send_notifications

    # def self.send_notifications(notification_params)
        # template = Template.find_by(id: notification_params[:template_id])
        # endpoint_ids = notification_params[:endpoint_ids]
        # notifications = []
        # endpoints = []
        # locations = []
        # endpoint_ids.each do |endpoint_id|
        #     notifications << Notification.create!(template_id: notification_params[:template_id], endpoint_id: endpoint_id, user_id: notification_params[:user_id], admin_id: notification_params[:admin_id])
        #     e_point = Endpoint.find_by(id: endpoint_id)
        #     if e_point.present?
        #         endpoints << e_point
        #     end
        # end
        # endpoints.each do |endpoint|
        #     if endpoint.location.present?
        #         locations << endpoint.location
        #     end
        # end
        # locations.each do |location|
        #     updateXml = UpdateXmlFileService.new(location, template).update_xml_file()
        # end
    # end

    def send_notifications
        template = Template.find_by(id: self.template_id)
        endpoint = Endpoint.find_by(id: self.endpoint_id)
        location = endpoint.location if endpoint.location.present?
        if location.present?
            updateXml = UpdateXmlFileService.new(location, template).update_xml_file()
        end
    end
end
