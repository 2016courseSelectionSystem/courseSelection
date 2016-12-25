require 'test_helper'

class CheckemptyroomControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
