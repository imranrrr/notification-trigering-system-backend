class Admin < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_many :templates, dependent: :destroy
  has_many :notifications
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
end
