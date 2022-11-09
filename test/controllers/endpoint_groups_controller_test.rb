require "test_helper"

class EndpointGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @endpoint_group = endpoint_groups(:one)
  end

  test "should get index" do
    get endpoint_groups_url, as: :json
    assert_response :success
  end

  test "should create endpoint_group" do
    assert_difference("EndpointGroup.count") do
      post endpoint_groups_url, params: { endpoint_group: { admin_id: @endpoint_group.admin_id, description: @endpoint_group.description, endpoint_type: @endpoint_group.endpoint_type, name: @endpoint_group.name } }, as: :json
    end

    assert_response :created
  end

  test "should show endpoint_group" do
    get endpoint_group_url(@endpoint_group), as: :json
    assert_response :success
  end

  test "should update endpoint_group" do
    patch endpoint_group_url(@endpoint_group), params: { endpoint_group: { admin_id: @endpoint_group.admin_id, description: @endpoint_group.description, endpoint_type: @endpoint_group.endpoint_type, name: @endpoint_group.name } }, as: :json
    assert_response :success
  end

  test "should destroy endpoint_group" do
    assert_difference("EndpointGroup.count", -1) do
      delete endpoint_group_url(@endpoint_group), as: :json
    end

    assert_response :no_content
  end
end
