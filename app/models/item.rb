require 'csv'

class Item < ApplicationRecord
  include Forecastable

  validates :product_code, presence: { message: '商品コードは必須です。' }, length: { is: 6, message: '商品コードは6文字である必要があります。' }
  validates :name, presence: { message: '名前は必須です。' }, length: { maximum: 255, message: '名前は255文字以内である必要があります。' }
  validates :order_date, presence: { message: '注文日は必須です。' }
  validates :order_quantity, presence: { message: '注文数量は必須です。' }

  def self.import(file)
    errors = [] # エラーメッセージを保存する配列
    CSV.foreach(file.path, headers: true) do |row|
      begin
        item = Item.new(row.to_hash.slice(*Item.attribute_names))
        item.order_date = Date.strptime(row['order_date'], '%Y-%m-%d') if row['order_date'].present? # 日付型に変換
        item.order_quantity = row['order_quantity'].to_i if row['order_quantity'].present? # 数値型に変換
        item.save!
      rescue => e
        errors << { row: row, message: e.message } # エラーメッセージを保存
      end
    end
    if errors.present?
      raise ImportError.new(errors) # エラーがある場合は例外を発生させる
    end
  end

  def self.to_csv(forecast_data)
    Rails.logger.info "Generating CSV from forecast data: #{forecast_data}"

    CSV.generate(headers: true) do |csv|
      csv << ["product_code", "name", "order_date", "order_quantity"]
      forecast_data.each do |data|
        # 生成された予測データをログに記録
        Rails.logger.info "Data row: #{data}"

        csv << [data["product_code"], data["name"], data["order_date"], data["order_quantity"]]
      end
    end
  end

  class ImportError < StandardError # カスタムエラークラス
    attr_reader :errors
    def initialize(errors)
      @errors = errors
      super("CSVファイルのインポートに失敗しました。")
    end
  end
end
