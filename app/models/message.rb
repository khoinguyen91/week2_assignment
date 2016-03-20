class Message < ActiveRecord::Base
	belongs_to :sender, class_name: "User", foreign_key: "sender_id"
    belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"
    paginates_per 5
    # mount_uploader :avatar, AvatarUploader
end
