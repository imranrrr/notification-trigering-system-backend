class Template < ApplicationRecord
    belongs_to :user, optional: true, foreign_key: :user_id
    belongs_to :admin, optional: true, foreign_key: :admin_id
    has_many :notifications
    mount_uploader :audio, TemplateAudioUploader

    validates :name, :subject, :body, :background_color, :font_color,  presence: true
end
