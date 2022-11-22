class Admins::WebSignagesController < ApplicationController
  before_action :set_web_signage, only: %i[ show update destroy ]

  def index
    begin
      web_signages = WebSignage.all
      render json: {
        web_signages: WebSignageSerializer.new(web_signages).serializable_hash[:data].map{|data| data[:attributes]}
      }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def show
    begin
      render json: {
        web_signage: WebSignageSerializer.new(@web_signage).serializable_hash[:data][:attributes]
      }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def create
    @web_signage = WebSignage.new(web_signage_params)
    begin
      if @web_signage.save!
        render json: {
          web_signage: WebSignageSerializer.new(@web_signage).serializable_hash[:data][:attributes]
        }
      end
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def update
    begin
      if @web_signage.update!(web_signage_params)
        render json: {
          web_signage: WebSignageSerializer.new(@web_signage).serializable_hash[:data][:attributes]
        }
      end
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def destroy
    begin
      render json: {
        message: "you just destroyed! Websignage",
        web_signage: @web_signage
        }
      @web_signage.destroy
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  private
    def set_web_signage
      begin
        @web_signage = WebSignage.find(params[:id])
      rescue => e
        render json: {status: 500, message: e.message}
      end
    end

    def web_signage_params
      params.require(:web_signage).permit(:name, :scroller_speed, :landscape_title_width, :landscape_title_height, :landscape_title_top, :landscape_title_left, :landscape_description_width, :landscape_description_height, :landscape_description_top, :landscape_description_left, :potrait_title_width, :potrait_title_height, :potrait_title_top, :potrait_title_left, :potrait_description_width, :potrait_description_height, :potrait_description_top, :potrait_description_left)
    end
end
