class Template < ApplicationRecord
    belongs_to  :user,optional: true, foreign_key: :creator_id
    belongs_to :admin, optional: true
    has_many :notifications
    belongs_to :company, optional: true
    mount_uploader :audio, TemplateAudioUploader


    # validates :name, :subject, :body, :background_color, :font_color,  presence: true

    enum creator_type: {
        default: 0,
        user: 1
    }
end
