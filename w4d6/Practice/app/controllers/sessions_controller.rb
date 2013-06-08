class SessionsController < ApplicationController

	def create
		@user = User.find_by_username(params[:user][:username])
		if @user.password_valid?(params[:user][:password])
			@user.generate_session_token
			session[:session_token] = @user.session_token
			redirect_to user_url(@user)
		else
			flash[:errors] ||= []
			flash[:errors] << "Invalid username/password combination."
			redirect_to new_session_url
		end
	end

	def new
	end

	def destroy
		u = current_user
		if u.nil?
			return
		end
		u.session_token = nil
		session[:session_token] = nil
		redirect_to new_session_url
	end
end