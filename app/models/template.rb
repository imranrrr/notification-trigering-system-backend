class Template < ApplicationRecord
    belongs_to :user, optional: true, foreign_key: :user_id
    belongs_to :admin, optional: true, foreign_key: :admin_id
    mount_uploader :audio, TemplateAudioUploader
end
