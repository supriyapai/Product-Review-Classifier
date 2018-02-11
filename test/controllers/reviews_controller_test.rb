require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get mark_eligible_reviews" do
    get :mark_eligible_reviews
    assert_response :success
  end

end
