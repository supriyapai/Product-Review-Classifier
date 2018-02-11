require 'test_helper'

class ClassifierControllerTest < ActionController::TestCase
  test "should get classify_helpful" do
    get :classify_helpful
    assert_response :success
  end

  test "should get classify_positive" do
    get :classify_positive
    assert_response :success
  end

end
