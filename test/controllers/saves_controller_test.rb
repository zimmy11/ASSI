require "test_helper"

class SavesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get saves_index_url
    assert_response :success
  end

  test "should get show" do
    get saves_show_url
    assert_response :success
  end

  test "should get new" do
    get saves_new_url
    assert_response :success
  end

  test "should get create" do
    get saves_create_url
    assert_response :success
  end

  test "should get edit" do
    get saves_edit_url
    assert_response :success
  end

  test "should get update" do
    get saves_update_url
    assert_response :success
  end

  test "should get destroy" do
    get saves_destroy_url
    assert_response :success
  end
end
