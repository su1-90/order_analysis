class ForecastsController < ApplicationController
  def create
    items = Item.where("order_date >= ?", 1.year.ago)

    if items.empty?
      flash[:alert] = "予測データがありません。商品データを登録してください。"
      redirect_to import_form_items_path
      return
    end

    # 遡る日数を指定
    days_back = 60
    forecast_data = WeeklyForecast.generate(items, days_back: days_back)

    if forecast_data.nil?
      flash[:alert] = "予測データの生成に失敗しました。"
      redirect_to import_form_items_path
      return
    end

    # 生成された予測データをログに記録
    Rails.logger.info "Final forecast data: #{forecast_data}"

    csv_data = Item.to_csv(forecast_data)
    Rails.logger.info "Generated CSV data: #{csv_data}"

    send_data csv_data, filename: "forecasts.csv"
  end

  def export
    items = Item.where("order_date >= ?", 1.year.ago)

    if items.empty?
      flash[:alert] = "予測データがありません。商品データを登録してください。"
      redirect_to root_path
      return
    end

    # 遡る日数を指定
    days_back = 60
    forecast_data = WeeklyForecast.generate(items, days_back: days_back)

    if forecast_data.nil?
      flash[:alert] = "予測データの生成に失敗しました。"
      redirect_to root_path
      return
    end

    # 生成された予測データをログに記録
    Rails.logger.info "Final forecast data: #{forecast_data}"

    csv_data = Item.to_csv(forecast_data)
    Rails.logger.info "Generated CSV data: #{csv_data}"

    send_data csv_data, filename: "forecasts.csv"
  end
end
