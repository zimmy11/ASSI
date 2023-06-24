require "test_helper"

class OrgEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get org_events_index_url
    assert_response :success
  end

  test "should get show" do
    get org_events_show_url
    assert_response :success
  end

  test "should get new" do
    get org_events_new_url
    assert_response :success
  end

  test "should get create" do
    get org_events_create_url
    assert_response :success
  end

  test "should get edit" do
    get org_events_edit_url
    assert_response :success
  end

  test "should get update" do
    get org_events_update_url
    assert_response :success
  end

  test "should get destroy" do
    get org_events_destroy_url
    assert_response :success
  end
end
