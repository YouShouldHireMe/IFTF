class PasswordResetsController < ApplicationController
  def new
        respond_to do |format|
            format.html {}
            format.js {}
            format.json {}
        end
  end

  def create
  	user = User.where(email: params[:email])
    @user_found = false;
    if user.first
       @user_found = true;
  	   user.first.send_password_reset
    end

    respond_to do |format|
            format.html {}
            format.js {}
            format.json {}
        end
  end

  def edit
  	@user = User.where(reset_password_token: params[:id]).first
    @user_found = false;
    if @user
      @user_found = true;
    end
  end

  def update
  	@user = User.where(reset_password_token: params[:id]).first
  	if @user.reset_password_sent_at < 2.hours.ago
  		redirect_to new_password_reset_path, :alert => "Password &crarr reset has expired."
  	elsif @user.update_attributes(params[:user])
  		redirect_to root_url, :notice => "Password has been reset."
  	else
  		render :edit
  	end
  end
end
