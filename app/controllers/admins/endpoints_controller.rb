class Admins::EndpointsController < ApplicationController
  before_action :set_endpoint, only: %i[ show update destroy ]

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

  # POST /endpoints
  def create
    @endpoint = Endpoint.create!(endpoint_params)
    if destination_params.present?
      @destination = Destination.new(destination_params)
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

  # PATCH/PUT /endpoints/1
  def update
    begin
      if @endpoint.update!(endpoint_params)
        if @endpoint.destination.present? && destination_params.present?
          existing_destination = Destination.find_by(id: @endpoint.destination_id)
          existing_destination.update!(destination_params)
        elsif destination_params.present?
          destination = Destination.new(destination_params)
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
      if  @endpoint.destination.present?
          @destination = Destination.find_by(id: @endpoint.destination_id)
          @destination.destroy!
          render json: {
            message: 200,
            endpoint: @endpoint
          }
      else
        @endpoint.destroy!
      end
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  private
    def set_endpoint
      begin
        action = params[:action]
        if action == "update"
          @endpoint = Endpoint.find(params[:id])
          # @endpoint = EndpointUpdateSerializer.new(endpoint).serializable_hash[:data][:attributes]
        else
          @endpoint = Endpoint.find(params[:id])
        end
      rescue => e
        render json: {status: 500, message: e.message}
      end
    end

    # Only allow a list of trusted parameters through.
    def endpoint_params
      params.require(:endpoint).permit(:name, :description, :location_id, :endpoint_group_id, :destination_id, :creator_id, :company_id)
    end

    def destination_params
      begin
        if params[:destination].present?
          params.require(:destination).permit(:destination_type, :resource_url, :network_distribution_id, :creator_id, :company_id)
        end
      rescue => e
        render json: {status: 500, message: e.message}
      end
    end
end
