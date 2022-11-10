require "test_helper"

class DestinationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @destination = destinations(:one)
  end

  test "should get index" do
    get destinations_url, as: :json
    assert_response :success
  end

  test "should create destination" do
    assert_difference("Destination.count") do
      post destinations_url, params: { destination: { admin_id: @destination.admin_id, destination_type: @destination.destination_type, network_distribution_id: @destination.network_distribution_id, resource_url: @destination.resource_url } }, as: :json
    end

    assert_response :created
  end

  test "should show destination" do
    get destination_url(@destination), as: :json
    assert_response :success
  end

  test "should update destination" do
    patch destination_url(@destination), params: { destination: { admin_id: @destination.admin_id, destination_type: @destination.destination_type, network_distribution_id: @destination.network_distribution_id, resource_url: @destination.resource_url } }, as: :json
    assert_response :success
  end

  test "should destroy destination" do
    assert_difference("Destination.count", -1) do
      delete destination_url(@destination), as: :json
    end

    assert_response :no_content
  end
end
