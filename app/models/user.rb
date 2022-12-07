class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :templates
  has_many :notifications
  has_many :transactions
  
  belongs_to :company, optional: true
  
  after_create :send_welcome_email
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable, :validatable,
          :jwt_authenticatable, jwt_revocation_strategy: self

  enum role: {
    "Notification User": 0,
    "Administrator": 1,
    "Super User": 2
  }

  enum status: {
    inactive: 0,
    active: 1
  }

  def jwt_payload
    super
  end

  def send_welcome_email
    begin
      UserMailer.with(user: self).welcome_email.deliver_later
    rescue Exception
      raise ArgumentError, "Something Went While Sending Welcome Email! :("
    end

  end
end
