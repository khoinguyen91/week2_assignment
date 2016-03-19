class UsersController < ApplicationController
  # before_action :require_login, only: [:index]
  # before_action :skipped_login, only: [:new]
  def new
  	@user = User.new
  end
  def show
    @user = current_user
  end
  def create
  	@user = User.create user_params
  	if @user.persisted?
  		session[:user_id] = @user.id
  		flash[:success] = "Congratulation! Welcome to Coder chat"
  		redirect_to root_path
  	else
  		flash.now[:error] = "Error: #{@user.errors.full_messages.to_sentence}"
  		render 'new'
  	end
  end
end

private
def user_params
  params.required(:user).permit(:name, :email, :password, :password_confirmation)
end
