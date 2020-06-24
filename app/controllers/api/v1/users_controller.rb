class Api::V1::UsersController < ApplicationController
	def create
		user = User.create(user_params)
		user.save
		if user.save
			render json: UserSerializer.new(user),
			status: 200
		else
			render json: {
				error: "Information not valid."
			},
			status: 400
		end
	end

	def index
		user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			render json: {
				"id": "#{user.id}",
				"email": "#{user.email}",
				"token": user.chat_token
			},
			status: 200
		else
			user = User.create(user_params)
			if user.save
				render json: {
					"id": "#{user.id}",
					"email": "#{user.email}",
					"token": user.chat_token
				},
				status: 200
			else
				render json: {
					error: "No dice..."
				},
				status: 404
			end
		end
	end

	private

	def user_params
		params.permit(:email, :password)
	end
end