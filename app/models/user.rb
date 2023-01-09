class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :templates, foreign_key: :creator_id
  has_many :notifications, foreign_key: :creator_id
  has_many :transactions, foreign_key: :creator_id
  has_many :locations, foreign_key: :creator_id
  has_many :endpoints, foreign_key: :creator_id
  has_many :endpoint_groups, foreign_key: :creator_id
  has_many :destinations, foreign_key: :creator_id
  
  belongs_to :company
  after_create :send_welcome_email
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :omniauthable, omniauth_providers: [:oktaoauth]

  # :database_authenticatable, :registerable, :validatable,
  #         :jwt_authenticatable, jwt_revocation_strategy: self

  enum role: {
    "Notification User": 0,
    "Administrator": 1
  }

  enum status: {
    inactive: 0,
    active: 1
  }

  def self.from_omniauth(auth)
    user = User.find_or_create_by(email: auth['info']['email']) do 
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.email = auth['info']['email']
    end
  end

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
