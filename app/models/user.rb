class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :templates
  has_many :notifications
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable, :validatable,
          :jwt_authenticatable, jwt_revocation_strategy: self

  enum role: {
    user: 0,
    admin: 1
  }

  def jwt_payload
    super
  end
end
