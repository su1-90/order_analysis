class UsersController < ApplicationController
  before_action :ensure_correct_admin, only: [:edit, :update, :destroy]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to users_path, notice: 'User was successfully destroyed.'
  rescue ActiveRecord::RecordNotDestroyed
    redirect_to users_path, alert: 'Userの削除に失敗しました。#{e.message}'
  end

  private

  def user_params
    params.require(:user).permit(:user_code, :password, :password_confirmation, :admin)
  end

  def ensure_correct_admin
    unless current_user.is_admin?
      redirect_to root_path, notice: 'You are not authorized to access this page.'
    end
  end
end
