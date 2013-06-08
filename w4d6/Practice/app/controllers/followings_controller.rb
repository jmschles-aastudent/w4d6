class FollowingsController < ApplicationController

	def create
		@current_user = current_user
		params[:following][:follower_id] = @current_user.id
		@following = Following.new(params[:following])
		if @following.save
			redirect_to user_url(@current_user)
		else
			flash[:errors] ||= []
			flash[:errors] << "Failed to follow."
			redirect_to users_url
		end
	end

	def destroy
		@current_user = current_user
		@following = Following.find(params[:id])
		@following.destroy
		redirect_to user_url(@current_user)
	end

end
