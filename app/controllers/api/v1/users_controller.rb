class Api::V1::UsersController < ApplicationController
	################### need to investigate React Routes ###################
	# def create
	# 	user = User.create(user_params)
	# 	user.save
	# 	if user.save
	# 		render json: {
	# 			"id": "#{user.id}",
	# 			"email": "#{user.email}",
	# 			"token": user.chat_token
	# 		},
	# 		status: 200
	# 	else
	# 		render json: {
	# 			error: "Information not valid."
	# 		},
	# 		status: 400
	# 	end
	# end

	def index
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			render json: {
				"id": user.username,
				"username": user.username,
				"token": user.chat_token
			},
			status: 200
		elsif user
			render json: {
				error: "Missing or incorrect authentication credentials."
			},
			status: 401
		else
			user = User.create(user_params)
			user.save
			if user.save
				render json: {
					"id": user.username,
					"username": user.username,
					"token": user.chat_token
				},
				status: 200
			else
				render json: {
					error: "User not saved."
				},
				status: 400
			end
		end
	end
		
	private

	def user_params
		params.permit(:username, :email, :password)
	end
end