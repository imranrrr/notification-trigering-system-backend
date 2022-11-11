class WebSignagesController < ApplicationController
  before_action :set_web_signage, only: %i[ show update destroy ]

  # GET /web_signages
  def index
    web_signages = WebSignage.all

    render json: {
      web_signages: WebSignageSerializer.new(web_signages).serializable_hash[:data].map{|data| data[:attributes]}
    }
  end

  # GET /web_signages/1
  def show
    render json: {
      web_signage: WebSignageSerializer.new(@web_signage).serializable_hash[:data][:attributes]
    }
  end

  # POST /web_signages
  def create
    @web_signage = WebSignage.new(web_signage_params)

    if @web_signage.save!
      render json: {
        web_signage: WebSignageSerializer.new(@web_signage).serializable_hash[:data][:attributes]
      }
    else
      render json: @web_signage.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /web_signages/1
  def update
    if @web_signage.update(web_signage_params)
      render json: {
        web_signage: WebSignageSerializer.new(@web_signage).serializable_hash[:data][:attributes]
      }
    else
      render json: @web_signage.errors, status: :unprocessable_entity
    end
  end

  # DELETE /web_signages/1
  def destroy
    render json: {
      message: "you just destroyed! Websignage",
      web_signage: @web_signage
      }
    @web_signage.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_web_signage
      @web_signage = WebSignage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def web_signage_params
      params.require(:web_signage).permit(:name, :scroller_speed, :landscape_title_width, :landscape_title_height, :landscape_title_top, :landscape_title_left, :landscape_description_width, :landscape_description_height, :landscape_description_top, :landscape_description_left, :potrait_title_width, :potrait_title_height, :potrait_title_top, :potrait_title_left, :potrait_description_width, :potrait_description_height, :potrait_description_top, :potrait_description_left)
    end
end
