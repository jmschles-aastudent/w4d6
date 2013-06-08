class UsersController < ApplicationController

	def index
		@current_user = current_user
		@users = User.all
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			render :show
		else
			flash[:errors] ||= []
			flash[:errors] << "Invalid username/password combination."
			redirect_to new_user_url
		end
	end

	def new
	end

	def show
		@user = User.find(params[:id])
		if @user == current_user
			render :show
		else
			flash[:errors] ||= []
			flash[:errors] << "Unauthorized to see other user's page."
			redirect_to users_url
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes
			render :show
		else
			flash[:errors] ||= []
			flash[:errors] << "Invalid user edit."
			redirect_to edit_user_url
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to users_url
	end

end
