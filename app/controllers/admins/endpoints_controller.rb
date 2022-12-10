class Admins::EndpointsController < ApplicationController
  before_action :set_endpoint, only: %i[ show update destroy ]
  before_action :authenticate_admin!

  def index
    begin
      endpoints = Endpoint.all
      render json: {
        status: 200,
        endpoints: EndpointSerializer.new(endpoints).serializable_hash[:data].map{|data| data[:attributes]}
      }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def show
    begin
      render json: {
        status: 200,
        endpoint: EndpointUpdateSerializer.new(@endpoint).serializable_hash[:data][:attributes]
      }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def create
    @endpoint = Endpoint.new(endpoint_params)
    @endpoint.creator_id = current_admin.id; @endpoint.creator_type = 0
    if @endpoint.save! && destination_params.present?
        @destination = Destination.new(destination_params)
        @destination.creator_id = current_admin.id; @destination.creator_type = 0
    end
    begin
      if  @destination.present? && @destination.save!
          @endpoint.update!(destination_id: @destination.id)
      end
      @endpoint.reload
      render json: {
          status: 200,
          endpoint: EndpointSerializer.new(@endpoint).serializable_hash[:data][:attributes]
          }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def update
    begin
      if @endpoint.update!(endpoint_params)
        if @endpoint.destination.present? && destination_params.present?
          existing_destination = Destination.find_by(id: @endpoint.destination_id)
          existing_destination.update!(destination_params)
        elsif destination_params.present?
          destination = Destination.new(destination_params)
          destination.creator_id = current_admin.id; destination.creator_type = 0
          if destination.save!
            @endpoint.update!(destination_id: destination.id) 
          end
        end
        @endpoint.reload
        render json: {
              status: 200,
              endpoint: EndpointSerializer.new(@endpoint).serializable_hash[:data][:attributes]
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
            endpoint: @endpoint
          }
        @endpoint.destroy!
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  private
    def set_endpoint
      begin
          @endpoint = Endpoint.find(params[:id])
      rescue => e
        render json: {status: 500, message: e.message}
      end
    end

    def endpoint_params
      params.require(:endpoint).permit(:name, :description, :location_id, :endpoint_group_id, :destination_id)
    end

    def destination_params
      begin
        if params[:destination].present?
          params.require(:destination).permit(:destination_type, :resource_url, :network_distribution_id)
        end
      rescue => e
        render json: {status: 500, message: e.message}
      end
    end
end
