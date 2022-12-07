class Template < ApplicationRecord
    belongs_to :user, foreign_key: :creator_id
    belongs_to :admin, optional: true
    has_many :notifications
    mount_uploader :audio, TemplateAudioUploader

    validates :name, :subject, :body, :background_color, :font_color,  presence: true
end
