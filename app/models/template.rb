class Template < ApplicationRecord
    belongs_to :user
    mount_uploader :audio, TemplateAudioUploader
end
