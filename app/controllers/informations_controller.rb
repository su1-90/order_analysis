class InformationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_information, only: [:edit, :update, :destroy]
  layout "no_header_footer", only: [:index, :new, :edit]

  def index
    @informations = Information.all
    redirect_to new_information_path if @informations.blank?
  end

  def new
    @information = Information.new
  end

  def create
    @information = Information.new(information_params)
    if @information.save
      redirect_to informations_path, notice: 'お知らせが正常に作成されました。'
    else
      flash.now[:alert] = 'エラーが発生しました。以下のメッセージを確認してください。'
      render :new, layout: "no_header_footer"
    end
  end

  def edit
  end

  def update
    if @information.update(information_params)
      redirect_to informations_path, notice: 'お知らせが正常に更新されました。'
    else
      flash.now[:alert] = 'エラーが発生しました。以下のメッセージを確認してください。'
      render :edit, layout: "no_header_footer"
    end
  end

  def destroy
    @information.destroy
    redirect_to informations_path, notice: 'お知らせが削除されました。'
  end

  private

  def set_information
    @information = Information.find(params[:id])
  end

  def information_params
    params.require(:information).permit(:message)
  end
end
