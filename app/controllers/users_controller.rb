class UsersController < ApplicationController
  before_action :ensure_correct_admin, only: [:edit, :update, :destroy]
  before_action :admin_user, only: [:new, :create]
  layout "user_registration", only: [:new, :create]
  layout "no_sidebar", only: [:index, :edit]

  def index
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザーが正常に作成されました。"
      redirect_to users_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path, notice: 'ユーザーは正常に更新されました'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = 'ユーザーは正常に破棄されました'
    else
      flash[:alert] = @user.errors.full_messages.join(', ')
    end

    respond_to do |format|
      format.html { redirect_to users_path }
      format.turbo_stream
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_code, :password, :password_confirmation, :admin)
  end

  def ensure_correct_admin
    unless current_user.admin?
      redirect_to root_path, notice: 'このページにアクセスする権限がありません'
    end
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
