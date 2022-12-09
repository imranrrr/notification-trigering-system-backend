class Template < ApplicationRecord
    belongs_to :user, foreign_key: :creator_id, optional: true
    belongs_to :admin, optional: true
    has_many :notifications
    mount_uploader :audio, TemplateAudioUploader

    # validates :name, :subject, :body, :background_color, :font_color,  presence: true

    enum creator_type: {
        default: 0,
        user: 1
    }
end
