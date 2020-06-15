class User < ApplicationRecord
	validates_presence_of :username
	validates_presence_of :email
	validates_uniqueness_of :email
	validates_presence_of :password_digest
	validates_presence_of :chat_token
end
