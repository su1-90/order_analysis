class ErrorsController < ApplicationController
  layout false

  def not_found
    render template: 'errors/not_found', layout: false, status: :not_found
  end

  def internal_server_error
    render inline: <<-HTML, status: :internal_server_error
      <!DOCTYPE html>
      <html>
      <head>
        <title>Server Error</title>
        <style>
          body {
            background-color: #f8f9fa;
            color: #333;
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
          }
          .container {
            text-align: center;
          }
          h1 {
            font-size: 50px;
          }
          p {
            font-size: 20px;
          }
          a {
            color: #223A70;
            text-decoration: none;
            font-weight: bold;
          }
          a:hover {
            text-decoration: underline;
          }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>500</h1>
          <p>内部サーバーエラーが発生しました。</p>
          <a href="<%= root_path %>">トップページに戻る</a>
        </div>
      </body>
      </html>
    HTML
  end
end
