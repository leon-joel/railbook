require 'test_helper'

class RecordControllerTest < ActionController::TestCase
  test "should get none" do
    get :none
    assert_response :success
  end

end
