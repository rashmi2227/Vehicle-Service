require "test_helper"

class ValidatesControllerTest < ActionDispatch::IntegrationTest
  test "should get validate" do
    get validates_validate_url
    assert_response :success
  end
end
