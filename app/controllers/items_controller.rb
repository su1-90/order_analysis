class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:edit, :update, :destroy]
  layout "no_sidebar", only: [:import_form]

  def import_form
    @item = Item.new
  end

  def import_csv
    if params[:file].nil?
      flash.now[:alert] = "ファイルが選択されていません。"
      render :import_form
    else
      begin
        Item.import(params[:file])
        flash.now[:notice] = "CSVファイルをインポートしました"
        render :import_form
      rescue Item::ImportError => e # カスタムエラークラスを捕捉
        flash.now[:alert] = "CSVファイルのインポートに失敗しました。#{e.message} #{e.errors.inspect}" # エラーメッセージを表示
        render :import_form
      rescue => e # その他のエラーを捕捉
        flash.now[:alert] = "CSVファイルのインポートに失敗しました。#{e.message}"
        render :import_form
      end
    end
  end

  def export
    @items = Item.all

    if @items.empty?
      flash[:alert] = "エクスポートするデータがありません"
      redirect_to informations_path
    else
      send_data Item.to_csv(@items), filename: "items.csv"
      flash[:notice] = "CSVファイルが正常にエクスポートされました"
      redirect_to informations_path
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
