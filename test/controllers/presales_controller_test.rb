require "test_helper"

class PresalesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get presales_index_url
    assert_response :success
  end

  test "should get show" do
    get presales_show_url
    assert_response :success
  end

  test "should get new" do
    get presales_new_url
    assert_response :success
  end

  test "should get create" do
    get presales_create_url
    assert_response :success
  end

  test "should get edit" do
    get presales_edit_url
    assert_response :success
  end

  test "should get update" do
    get presales_update_url
    assert_response :success
  end

  test "should get destroy" do
    get presales_destroy_url
    assert_response :success
  end
end
