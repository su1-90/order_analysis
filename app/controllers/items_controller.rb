class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:edit, :update, :destroy]
  layout "no_sidebar", only: [:import_form]

  def import_form
    @item = Item.new
  end

  def import_csv
    if params[:file].nil?
      @message = { type: :alert, text: "ファイルが選択されていません。" }
      render :import_form
    else
      begin
        Item.import(params[:file])
        @message = { type: :notice, text: "CSVファイルをインポートしました。" }
        render :import_form
      rescue Item::ImportError => e # カスタムエラークラスを捕捉
        @message = { type: :alert, text: "CSVファイルのインポートに失敗しました。#{e.message} #{e.errors.inspect}" } # エラーメッセージを表示
        render :import_form
      rescue => e # その他のエラーを捕捉
        @message = { type: :alert, text: "CSVファイルのインポートに失敗しました。#{e.message}" }
        render :import_form
      end
    end
  end

  def export
    @items = Item.all

    if @items.empty?
      @message = { type: :alert, text: "エクスポートするデータがありません。" }
      redirect_to informations_path
    else
      send_data Item.to_csv(@items), filename: "items.csv"
      @message = { type: :notice, text: "CSVファイルが正常にエクスポートされました。" }
      redirect_to informations_path
    end
  end

  def reset_data
    if Item.exists?
      Item.delete_all
      @message = { type: :notice, text: '保存していたデータをすべて削除しました。' }
    else
      @message = { type: :alert, text: '初期化するデータがありません。' }
    end
    render :import_form
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:product_code, :name, :order_date, :order_quantity)
  end
end
