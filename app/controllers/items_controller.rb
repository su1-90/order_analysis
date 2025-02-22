class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:edit, :update, :destroy]
  layout "no_sidebar", only: [:import_form, :import_csv]

  def import_form
    Rails.logger.info "Entering import_form action"
    @item = Item.new
    Rails.logger.info "Exiting import_form action"
  end

  def import_csv
    if params[:file].nil?
      flash.now[:alert] = "ファイルが選択されていません。"
      render :import_form
    else
      begin
        Item.import(params[:file])
        flash[:notice] = "CSVファイルをインポートしました"
        redirect_to import_form_items_path
      rescue Item::ImportError
        render :import_form # メッセージを表示せず何もしない
      rescue
        render :import_form # メッセージを表示せず何もしない
      end
    end
  end

  def export
    Rails.logger.info "Entering export action"
    @items = Item.all

    if @items.empty?
      flash[:alert] = "エクスポートするデータがありません"
      redirect_to informations_path
    else
      send_data Item.to_csv(@items), filename: "items.csv"
      flash[:notice] = "CSVファイルが正常にエクスポートされました"
      redirect_to informations_path
    end
    Rails.logger.info "Exiting export action"
  end

  def reset_data
    if Item.exists?
      Item.delete_all
      render json: { message: '保存していたデータをすべて削除しました。', type: 'notice' }
    else
      render json: { message: '初期化するデータがありません。', type: 'alert' }
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:product_code, :name, :order_date, :order_quantity)
  end
end
