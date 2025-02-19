require "openai"
require "csv"

class WeeklyForecast
  def self.generate(items, days_back: 30)
    client = OpenAI::Client.new(
      access_token: ENV["OPENAI_ACCESS_TOKEN"],
      organization_id: ENV["OPENAI_ORGANIZATION_ID"]
    )

    recent_items = items.where("order_date >= ?", days_back.days.ago)

    if recent_items.empty?
      Rails.logger.error "No recent items found for forecasting. Using all data instead."
      recent_items = items
    end

    if recent_items.empty?
      Rails.logger.error "No items found for forecasting."
      return nil
    end

    csv_data = CSV.generate(headers: true) do |csv|
      csv << recent_items.first.attributes.keys
      recent_items.each do |item|
        row = item.attributes.values
        row = row.map { |v| v.is_a?(Date) ? v.strftime('%Y-%m-%d') : v }
        csv << row
      end
    end

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "あなたはデータサイエンティストです。過去の受注データに基づいて、次の1週間の日付ごとの受注数量を予測し、JSON形式で返してください。各予測には 'product_code', 'name', 'order_date', 'order_quantity' のフィールドを含めてください。" },
          { role: "user", content: "過去の受注データ:\n#{csv_data}" }
        ]
      }
    )

    Rails.logger.info "OpenAI Response: #{response}"

    forecast = response.dig("choices", 0, "message", "content")

    if forecast
      Rails.logger.info "Forecast: #{forecast}"
    else
      Rails.logger.error "No forecast received from OpenAI."
      return nil
    end

    if forecast&.include?("```json")
      forecast_code = forecast.match(/```(?:\w*)\n(.*)```/m)[1]
      Rails.logger.info "Parsed JSON code: #{forecast_code}"

      begin
        forecast_data = JSON.parse(forecast_code)

        # デバッグ用に生成された予測データをログに記録
        Rails.logger.info "Generated forecast data: #{forecast_data}"

        return forecast_data
      rescue JSON::ParserError
        Rails.logger.error "Failed to parse forecast: #{forecast_code}"
        return nil
      end
    else
      Rails.logger.error "Unexpected forecast format: #{forecast}"
      return nil
    end
  end
end
