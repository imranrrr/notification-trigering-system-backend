class Admins::IcMobilesController < ApplicationController
  before_action :set_ic_mobile, only: %i[ show update destroy ]
  before_action :authenticate_admin!

  def index
    begin
      @ic_mobiles = IcMobile.all
      render json: {
        status: 200, 
        ic_mobiles: IcMobileSerializer.new(@ic_mobiles).serializable_hash[:data].map{|data| data[:attributes]}
      }
      rescue => e
        render json: {status: 500, message: e.message}
      end
  end

  def show
    begin
      render json: {
        status: 200,
        ic_mobile: IcMobileSerializer.new(@ic_mobile).serializable_hash[:data][:attributes]
      }
    rescue => e
      render json: {
        status: 500, 
        message: e.message
      }
    end
  end

  def create
    @ic_mobile = IcMobile.new(ic_mobile_params)
    begin
      if @ic_mobile.save!
        render json: {
          status: 200,
          ic_mobile: IcMobileSerializer.new(@ic_mobile).serializable_hash[:data][:attributes]
        }
      end
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def update
    begin
      if @ic_mobile.update!(ic_mobile_params)
        render json: {
          status: 200, 
          ic_mobile: IcMobileSerializer.new(@ic_mobile).serializable_hash[:data][:attributes]
        }
      end
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def destroy
    begin
      render json: {
        status: 200, 
        ic_mobile: @ic_mobile
      } 
      @ic_mobile.destroy
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  private
    def set_ic_mobile
      @ic_mobile = IcMobile.find(params[:id])
    end

    def ic_mobile_params
      params.require(:ic_mobile).permit(:name)
    end
end
