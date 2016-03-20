class User < ActiveRecord::Base
	has_secure_password
	validates :email, uniqueness: true
	validates :name, presence: true
	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user
	has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
    has_many :received_messages, class_name: "Message", foreign_key: "recipient_id"
    def self.from_omniauth(auth)
      where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.email = auth.uid
        user.name = auth.info.name
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.save!
      end
    end
end
