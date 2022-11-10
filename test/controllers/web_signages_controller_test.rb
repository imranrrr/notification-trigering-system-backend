require "test_helper"

class WebSignagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @web_signage = web_signages(:one)
  end

  test "should get index" do
    get web_signages_url, as: :json
    assert_response :success
  end

  test "should create web_signage" do
    assert_difference("WebSignage.count") do
      post web_signages_url, params: { web_signage: { landscape_description_height: @web_signage.landscape_description_height, landscape_description_left: @web_signage.landscape_description_left, landscape_description_top: @web_signage.landscape_description_top, landscape_description_width: @web_signage.landscape_description_width, landscape_title_height: @web_signage.landscape_title_height, landscape_title_left: @web_signage.landscape_title_left, landscape_title_top: @web_signage.landscape_title_top, landscape_title_width: @web_signage.landscape_title_width, name: @web_signage.name, potrait_description_height: @web_signage.potrait_description_height, potrait_description_left: @web_signage.potrait_description_left, potrait_description_top: @web_signage.potrait_description_top, potrait_description_width: @web_signage.potrait_description_width, potrait_title_height: @web_signage.potrait_title_height, potrait_title_left: @web_signage.potrait_title_left, potrait_title_top: @web_signage.potrait_title_top, potrait_title_width: @web_signage.potrait_title_width, scroller_speed: @web_signage.scroller_speed } }, as: :json
    end

    assert_response :created
  end

  test "should show web_signage" do
    get web_signage_url(@web_signage), as: :json
    assert_response :success
  end

  test "should update web_signage" do
    patch web_signage_url(@web_signage), params: { web_signage: { landscape_description_height: @web_signage.landscape_description_height, landscape_description_left: @web_signage.landscape_description_left, landscape_description_top: @web_signage.landscape_description_top, landscape_description_width: @web_signage.landscape_description_width, landscape_title_height: @web_signage.landscape_title_height, landscape_title_left: @web_signage.landscape_title_left, landscape_title_top: @web_signage.landscape_title_top, landscape_title_width: @web_signage.landscape_title_width, name: @web_signage.name, potrait_description_height: @web_signage.potrait_description_height, potrait_description_left: @web_signage.potrait_description_left, potrait_description_top: @web_signage.potrait_description_top, potrait_description_width: @web_signage.potrait_description_width, potrait_title_height: @web_signage.potrait_title_height, potrait_title_left: @web_signage.potrait_title_left, potrait_title_top: @web_signage.potrait_title_top, potrait_title_width: @web_signage.potrait_title_width, scroller_speed: @web_signage.scroller_speed } }, as: :json
    assert_response :success
  end

  test "should destroy web_signage" do
    assert_difference("WebSignage.count", -1) do
      delete web_signage_url(@web_signage), as: :json
    end

    assert_response :no_content
  end
end
