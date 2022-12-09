class Admins::IntegrationsController < ApplicationController
  before_action :set_integration, only: %i[ show update destroy ]
  before_action :authenticate_admin!

  def index
    begin
      @integrations = Integration.all
      render json:{
        status: 200,
        integrations: IntegrationSerializer.new(@integrations).serializable_hash[:data].map{|data| data[:attributes]}
      }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def show
    begin
      render json: {
          status: 200,
          integration: IntegrationSerializer.new(@integration).serializable_hash[:data][:attributes]
        }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def create
    @integration = Integration.new(integration_params)
    begin
      if @integration.save!
        render json: {
          status: 200,
          integration: IntegrationSerializer.new(@integration).serializable_hash[:data][:attributes]
        }
      end
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def update
    begin
      if @integration.update!(integration_params)
        render json: {
          status: 200,
          integration: IntegrationSerializer.new(@integration).serializable_hash[:data][:attributes]
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
        integration: @integration 
      }
      @integration.destroy
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  private
    def set_integration
      @integration = Integration.find(params[:id])
    end

    def integration_params
      params.require(:integration).permit(:name, :client_id, :client_secret, :base_url, :admin_id)
    end
end
