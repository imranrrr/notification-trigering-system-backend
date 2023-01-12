class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :templates, foreign_key: :creator_id
  has_many :notifications, foreign_key: :creator_id
  has_many :transactions, foreign_key: :creator_id
  has_many :locations, foreign_key: :creator_id
  has_many :endpoints, foreign_key: :creator_id
  has_many :endpoint_groups, foreign_key: :creator_id
  has_many :destinations, foreign_key: :creator_id
  
  belongs_to :company, optional: true
  after_create :send_welcome_email
  validates :uid, presence: false
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # include  DeviseTokenAuth::Concerns::User 
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, omniauth_providers: %i[google_oauth2] 
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

  def self.signin_or_create_from_provider(provider_data)
    where(provider: provider_data[:data][:provider], uid: provider_data[:data][:uid]).first_or_create do |user|
      user.email = provider_data[:data][:info][:email]
      user.password = Devise.friendly_token[0, 20]
      user.status = 1
      user.skip_confirmation! # when you signup a new user, you can decide to skip confirmation
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
