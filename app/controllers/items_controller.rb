class InformationsController < ApplicationController
  def index
    @items = Item.all.order(id: :"DESC")

    @informations = Information.all
    if @informations.empty?
      @default_message = "現在お知らせはありません"
    end
  end

  def import
    @tems = Items.import(params[:file])
    @items.save!
    redirect_to products_path, notice: "CSV インポートが完了しました。"
  end

  def download
    
  end


  def edit_info
    @information = Information.find(params[:id])
  end

  def update_info
    @information = Information.find(params[:id])
    if @information.update(information_params)
      redirect_to informations_path, notice: "お知らせを更新しました"
    else
      render :edit_info
    end
  end

  private

  def information_params
    params.require(:information).permit(:title, :message)
  end
end