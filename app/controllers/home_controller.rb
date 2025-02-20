class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    # raise StandardError.new("This is a test error for 500 page") # この行を追加
  end
end
