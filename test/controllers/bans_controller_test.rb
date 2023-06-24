require "test_helper"

class BansControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bans_index_url
    assert_response :success
  end

  test "should get show" do
    get bans_show_url
    assert_response :success
  end

  test "should get new" do
    get bans_new_url
    assert_response :success
  end

  test "should get create" do
    get bans_create_url
    assert_response :success
  end

  test "should get edit" do
    get bans_edit_url
    assert_response :success
  end

  test "should get update" do
    get bans_update_url
    assert_response :success
  end

  test "should get destroy" do
    get bans_destroy_url
    assert_response :success
  end
end
