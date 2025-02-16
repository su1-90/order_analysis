class InformationsController < ApplicationController
  before_action :set_information, only: [:edit, :update]

  # def new
  #   @information = Information.new
  # end

  def create
    @information = Information.new(information_params)
    if @information.save
      redirect_to informations_path, notice: 'お知らせを作成しました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @information.update(information_params)
      redirect_to informations_path, notice: 'お知らせを更新しました。'
    else
      render :edit
    end
  end

  private

  def set_information
    @information = Information.find(params[:id])
  end

  def information_params
    params.require(:information).permit(:title, :message)
  end
end