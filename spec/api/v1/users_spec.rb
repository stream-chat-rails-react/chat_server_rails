require 'rails_helper'

RSpec.describe "Users" do
	before :each do
		@username = "philjdelong"
		@email = "sample@email.com"
		@password = "password"
	end
	
	it "can create a new user account" do
		post "/api/v1/auth?username=#{@username}&email=#{@email}&password=#{@password}&password_confirmation=#{@password}"
		expect(response).to be_successful
		
		expect(User.count).to eq(1)
	end
	
	it "can login to an existing user account" do
		@phil = User.create(
			username: @username,
			email: @email,
			password: @password,
			password_confirmation: @password
		)
		post "/api/v1/auth?username=#{@phil.username}&password=#{@phil.password}"
		expect(response).to be_successful
		
		parsed = JSON.parse(response.body)
		user_data = {
			"id" => @phil.username,
			"username" => @phil.username,
			"token" => @phil.chat_token
		}

		expect(parsed).to eq(user_data)
	end
end