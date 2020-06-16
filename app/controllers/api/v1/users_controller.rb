class Api::V1::UsersController < ApplicationController
	def create
		user = User.create(user_params)
		user.save
		if user.save
			render json: {
				success: "User successfully created!"
			},
			status: 200
		else
			render json: {
				error: "Information not valid."
			},
			status: 400
		end
	end

	def show
		user = User.find_by(email: params[:email])
		if user
			render json: UserSerializer.new(user),
			status: 200
		else
			render json: {
				error: "Missing or incorrect authentication credentials."
			},
			status: 401
		end
	end

	private

	def user_params
		params.permit(:username, :email, :password, :password_confirmation)
	end
end