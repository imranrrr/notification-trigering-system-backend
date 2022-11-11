class Admins::DestinationsController < ApplicationController
  before_action :set_destination, only: %i[ show update destroy ]

  def index
    begin
      destinations = Destination.all
      render json: {
        destinations: DestinationSerializer.new(destinations).serializable_hash[:data].map{|data| data[:attributes]}
        }
    rescue => e
      render json: e.message
    end
  end

  def show
    begin
      render json: {
        destination: DestinationSerializer.new(@destination).serializable_hash[:data][:attributes]
      }
    rescue => e
      render json: e.message
    end
  end

  def create
    destination = Destination.new(destination_params)
    begin
      if destination.save!
         render json: {
           status: true,
           destination: DestinationSerializer.new(destination).serializable_hash[:data][:attributes]
           }
      end
    rescue => e
        render json: e.message
    end
  end

  def update
    begin 
        @destination.update!(destination_params)
        render json: {
          status: true,
          destination: DestinationSerializer.new(@destination).serializable_hash[:data][:attributes]
        }
    rescue => e
      render json: e.message
    end
  end

  def destroy
    begin
      render json: {
          status: true,
          message: "you just deleted! Destination",
          destination: @destination
        }
      @destination.destroy
    rescue => e
      render json: e.message
    end
  end

  private
    def set_destination
      begin
        @destination = Destination.find(params[:id])
      rescue => e
        render json: e.message
      end
    end

    def destination_params
      params.require(:destination).permit(:destination_type, :resource_url, :network_distribution_id, :admin_id)
    end
end
