class UserSerializer
	include FastJsonapi::ObjectSerializer
	attributes :username, :email, :chat_token
end