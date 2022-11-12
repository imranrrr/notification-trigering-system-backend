class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :templates
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable, :validatable, :jwt_authenticatable,:omniauthable, jwt_revocation_strategy: self,  omniauth_providers: [:oktaoauth]

  def self.from_omniauth(auth)
    user = User.find_or_create_by(email: auth['info']['email']) do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.email = auth['info']['email']
    end
  end

  def jwt_payload
    super
  end
end
