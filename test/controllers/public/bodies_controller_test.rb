require "test_helper"

class Public::BodiesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_bodies_new_url
    assert_response :success
  end

  test "should get show" do
    get public_bodies_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_bodies_edit_url
    assert_response :success
  end
end
