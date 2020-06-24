require 'stream-chat'

class User < ApplicationRecord
	validates :email, uniqueness: true
	validates_presence_of :email, :password_digest
	has_secure_password

	def chat_token
		uuid = self.id.to_s
		client = StreamChat::Client.new(api_key = ENV["STREAM_API_KEY"], api_secret = ENV["STREAM_API_SECRET"])
		token = client.create_token(uuid)
		client.update_user({
			id: uuid,
			role: 'admin',
			name: self.email
		})
		chan = client.channel("messaging", channel_id: "General")
		chan.create(uuid)
		chan.add_members([uuid])
		token
	rescue StandardError => e
		p e
		"Token saved."
	end
end
