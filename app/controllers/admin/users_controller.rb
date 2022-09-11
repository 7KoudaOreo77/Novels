class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page])

  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(admin_user_params)
      redirect_to admin_users_path
    else
      render edit_admin_user_path
    end
  end

  def withdrawal
    @user = User.find(params[:id])
  end

  def out
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def admin_user_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end
end
