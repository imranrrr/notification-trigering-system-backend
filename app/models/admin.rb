class Admin < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :templates, dependent: :destroy
  has_many :notifications
  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def send_welcome_email
    begin
      AdminMailer.with(admin: self).welcome_email.deliver_later
    rescue Exception
      raise ArgumentError, "Something Went While Sending Welcome Email! :("
    end
  end
end
