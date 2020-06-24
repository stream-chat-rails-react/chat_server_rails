class UserSerializer
	include FastJsonapi::ObjectSerializer
	attributes :email, :chat_token
end