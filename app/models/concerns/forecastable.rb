module Forecastable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def to_csv(forecast_data)
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
  end
end
