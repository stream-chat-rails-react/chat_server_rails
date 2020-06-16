require 'rails_helper'

RSpec.describe "Users" do
	before :each do
		username = "philjdelong"
		email = "sample@email.com"
		password = "password"
		
		@phil = User.create(
			username: username,
			email: email,
			password: password,
			password_confirmation: password
		)
	end

	it "can login to an existing user account" do
		get "/api/v1/auth?username=#{@phil.username}&password=#{@phil.password}"
		expect(response).to be_successful
		parsed = JSON.parse(response.body)
		
		user_data = {
			"username" => @phil.username,
			"email" => @phil.email,
			"chat_token" => @phil.chat_token
		}

		expect(parsed["data"]["attributes"]).to eq(user_data)
		expect(User.count).to eq(1)
	end
end