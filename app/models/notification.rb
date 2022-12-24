class Notification < ApplicationRecord
    belongs_to :template, optional: true, foreign_key: :template_id
    belongs_to :endpoint, optional: true, foreign_key: :endpoint_id
    belongs_to :admin, optional: true, foreign_key: :admin_id
    belongs_to :user, optional: true, foreign_key: :creator_id
    after_save :send_notifications
    after_create :send_email

    def send_notifications
        template = Template.find_by(id: self.template_id)
        endpoint = Endpoint.find_by(id: self.endpoint_id)
        location = endpoint.location if endpoint.location.present?
        if location.present?
            updateXml = UpdateXmlFileService.new(location, template).update_xml_file_with_notification()
        end
    end

    # def send_email
    #     if self.user_id != nil
    #         user = User.find_by(id: self.user_id)
    #         UserMailer.with(user: user).notification_email.deliver_later if user.present?
    #     elsif self.admin_id != nil
    #         admin = Admin.find_by(id: self.admin_id)
    #         AdminMailer.with(admin: admin).notification_email.deliver_later if admin.present?
    #     end
    # end

    def send_email
      if self.creator_id != nil
        user = User.find_by(id: self.creator_id)
        if user.present?
          UserMailer.with(user: user).notification_email.deliver_later
        end
      else self.admin_id != nil
        admin = Admin.find_by(id: self.admin_id)
        if user.present?
          AdminMailer.with(user: admin).notification_email.deliver_later
        end
      end
    end
end
