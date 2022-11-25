class AdminMailer < ApplicationMailer
    default from: 'notifications@example.com'

    def welcome_email
      @admin = params[:admin]
      @url  = 'http://localhost:3001'
      mail(to: @admin.email, subject: 'Welcome to NTS!')
    end

    def notification_email
        @admin = params[:admin]
        @url  = 'http://localhost:3001'
        mail(to: @admin.email, subject: 'Notification Sent!')
      end
end
