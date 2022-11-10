require "test_helper"

class EndpointsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @endpoint = endpoints(:one)
  end

  test "should get index" do
    get endpoints_url, as: :json
    assert_response :success
  end

  test "should create endpoint" do
    assert_difference("Endpoint.count") do
      post endpoints_url, params: { endpoint: { admin_id: @endpoint.admin_id, description: @endpoint.description, destination_id: @endpoint.destination_id, endpoint_group_id: @endpoint.endpoint_group_id, location_id: @endpoint.location_id, name: @endpoint.name } }, as: :json
    end

    assert_response :created
  end

  test "should show endpoint" do
    get endpoint_url(@endpoint), as: :json
    assert_response :success
  end

  test "should update endpoint" do
    patch endpoint_url(@endpoint), params: { endpoint: { admin_id: @endpoint.admin_id, description: @endpoint.description, destination_id: @endpoint.destination_id, endpoint_group_id: @endpoint.endpoint_group_id, location_id: @endpoint.location_id, name: @endpoint.name } }, as: :json
    assert_response :success
  end

  test "should destroy endpoint" do
    assert_difference("Endpoint.count", -1) do
      delete endpoint_url(@endpoint), as: :json
    end

    assert_response :no_content
  end
end
