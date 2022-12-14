class Admins::EndpointGroupsController < ApplicationController
  before_action :set_endpoint_group, only: %i[ show update destroy ]

  def index
    begin   
      endpoint_groups = EndpointGroup.all
      render json:{
        status: 200,
        endpoint_groups: EndpointGroupSerializer.new(endpoint_groups).serializable_hash[:data].map{|data| data[:attributes]}
      }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def show
    begin
      render json: {
        status: 200,
        endpoint_group: EndpointGroupUpdateSerializer.new(@endpoint_group).serializable_hash[:data][:attributes]
      }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def create
    endpoint_group = EndpointGroup.new(endpoint_group_params)
    begin
      if endpoint_group.save!
        render json: {
          status: 200,
          endpoint_group: EndpointGroupSerializer.new(endpoint_group).serializable_hash[:data][:attributes]
        }
      end
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  # PATCH/PUT /endpoint_groups/1
  def update
    begin
      if @endpoint_group.update!(endpoint_group_params)
        render json: {
          status: 200,
          endpoint_group: EndpointGroupSerializer.new(@endpoint_group).serializable_hash[:data][:attributes]
          }
      end
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  # DELETE /endpoint_groups/1
  def destroy
    begin
      render json: {
          status: 200,
          endppointGroup: @endpoint_group
        }
      @endpoint_group.destroy
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  private
    def set_endpoint_group
      begin
          @endpoint_group = EndpointGroup.find(params[:id])
      rescue => e
        render json: {status: 500, message: e.message}
      end
    end

    def endpoint_group_params
      params.require(:endpoint_group).permit(:name, :description, :endpoint_type, :creator_id, :company_id)
    end
end
