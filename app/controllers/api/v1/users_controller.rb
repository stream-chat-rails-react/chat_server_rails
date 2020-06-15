class Api::V1::UsersController < ApplicationController
	def create
		user = User.create(user_params)
		unless user.save
			render json: {
				error: "Information not valid."
			},
			status: 400
		else
			render json: {
				success: "User successfully created!"
			},
			status: 200
		end
	end

	def show
		user = User.find_by(username: params[:username])
		unless user
			render json: {
				error: "Missing or incorrect authentication credentials."
			},
			status: 401
		else
			render json: UserSerializer.new(user),
			status: 200
		end
	end

	private

	def user_params
		params.permit(:username, :email, :password, :password_confirmation)
	end
end