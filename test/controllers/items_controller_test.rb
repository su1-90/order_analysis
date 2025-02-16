require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
test "should get index" do
  get items_url
  assert_response :success
end

