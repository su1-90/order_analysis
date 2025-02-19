class Openai
  attr_reader :order_quantity

  def initialize(order_quantity)
    @order_quantity = order_quantity
  end

  def post
    client = OpenAI::Client.new
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "明日のお弁当の予測数量を立ててください。本日のデータはこちらです" },
          { role: "user", content: @order_quantity }
        ],
        temperature: 0.7
      }
    )
    response.dig("choices", 0, "message", "content")
  end
end