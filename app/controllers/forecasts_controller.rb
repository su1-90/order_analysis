class ForecastsController < ApplicationController
  def create
    items = Item.where("order_date >= ?", 1.year.ago)

    if items.empty?
      flash[:alert] = "予測データがありません。商品データを登録してください。"
      redirect_to import_form_items_path and return
    end

    # 遡る日数を指定
    days_back = 60
    forecast_data = WeeklyForecast.generate(items, days_back: days_back)

    if forecast_data.nil?
      flash[:alert] = "予測データの生成に失敗しました。"
      redirect_to import_form_items_path and return
    end

    # 生成された予測データをログに記録
    Rails.logger.info "Final forecast data: #{forecast_data}"

    begin
      csv_data = Item.to_csv(forecast_data)
      Rails.logger.info "Generated CSV data: #{csv_data}"

      send_data csv_data, filename: "forecasts.csv"
    rescue => e
      Rails.logger.error "Error generating or sending CSV data: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      flash[:alert] = "CSVデータの生成または送信に失敗しました。"
      redirect_to import_form_items_path
    end
  end

  def export
    items = Item.where("order_date >= ?", 1.year.ago)

    if items.empty?
      flash[:alert] = "予測データがありません。商品データを登録してください。"
      redirect_to root_path and return
    end

    # 遡る日数を指定
    days_back = 60
    forecast_data = WeeklyForecast.generate(items, days_back: days_back)

    if forecast_data.nil?
      flash[:alert] = "予測データの生成に失敗しました。"
      redirect_to root_path and return
    end

    # 生成された予測データをログに記録
    Rails.logger.info "Final forecast data: #{forecast_data}"

    begin
      csv_data = Item.to_csv(forecast_data)
      Rails.logger.info "Generated CSV data: #{csv_data}"

      send_data csv_data, filename: "forecasts.csv"
    rescue => e
      Rails.logger.error "Error generating or sending CSV data: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      flash[:alert] = "CSVデータの生成または送信に失敗しました。"
      redirect_to root_path
    end
  end
end
