class Admins::IcMobilesController < ApplicationController
  before_action :set_ic_mobile, only: %i[ show update destroy ]

  # GET /ic_mobiles
  def index
    @ic_mobiles = IcMobile.all

    render json: @ic_mobiles
  end

  # GET /ic_mobiles/1
  def show
    render json: @ic_mobile
  end

  # POST /ic_mobiles
  def create
    @ic_mobile = IcMobile.new(ic_mobile_params)

    if @ic_mobile.save
      render json: @ic_mobile, status: :created, location: @ic_mobile
    else
      render json: @ic_mobile.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ic_mobiles/1
  def update
    if @ic_mobile.update(ic_mobile_params)
      render json: @ic_mobile
    else
      render json: @ic_mobile.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ic_mobiles/1
  def destroy
    @ic_mobile.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ic_mobile
      @ic_mobile = IcMobile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ic_mobile_params
      params.fetch(:ic_mobile, {})
    end
end
