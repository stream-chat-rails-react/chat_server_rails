require 'stream-chat'

class User < ApplicationRecord
	validates :username, uniqueness: true
	validates :email, uniqueness: true
	validates_presence_of :username, :email, :password_digest
	has_secure_password

	def chat_token
		client = StreamChat::Client.new(api_key = ENV["STREAM_API_KEY"], api_secret = ENV["STREAM_API_SECRET"])
		token = client.create_token(self.username)
		client.update_user({
			id: self.username,
			name: self.username
		})
		chan = client.channel("messaging", channel_id: "stream-chat-#{self.username}")
		chan.create("admin")
		chan.add_members(["admin", self.username])
		token
	rescue StandardError => e
		p e
		"User token saved."
	end
end
