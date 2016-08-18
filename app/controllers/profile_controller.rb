class ProfileController < ApplicationController
	before_action :authenticate_user!

	def show
		@user 		= User.find(params[:id])
		@posts		= @user.posts
		@comments	= @user.comments
		@tags		= @user.tags
	end
end