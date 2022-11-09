class Admins::EndpointGroupsController < ApplicationController
  before_action :set_endpoint_group, only: %i[ show update destroy ]

  # GET /endpoint_groups
  def index
    endpoint_groups = EndpointGroup.all

    render json:{
      endpoint_groups: EndpointGroupSerializer.new(endpoint_groups).serializable_hash[:data].map{|data| data[:attributes]}
    }
  end

  # GET /endpoint_groups/1
  def show
    render json: {
      endpoint_group: EndpointGroupSerializer.new(@endpoint_group).serializable_hash[:data][:attributes]
    }
  end

  # POST /endpoint_groups
  def create
    endpoint_group = EndpointGroup.new(endpoint_group_params)

    if endpoint_group.save
      render json: {
        endpoint_group: EndpointGroupSerializer.new(endpoint_group).serializable_hash[:data][:attributes]
      }
    else
      render json: @endpoint_group.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /endpoint_groups/1
  def update
    if @endpoint_group.update(endpoint_group_params)
      render json: {
        endpoint_group: EndpointGroupSerializer.new(@endpoint_group).serializable_hash[:data][:attributes]
      }
    else
      render json: @endpoint_group.errors, status: :unprocessable_entity
    end
  end

  # DELETE /endpoint_groups/1
  def destroy
    render json: {
        status: "you just destroyed! Endppoint Group",
        endppointGroup: @endpoint_group
      }
    @endpoint_group.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_endpoint_group
      @endpoint_group = EndpointGroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def endpoint_group_params
      params.require(:endpoint_group).permit(:name, :description, :endpoint_type, :admin_id)
    end
end
