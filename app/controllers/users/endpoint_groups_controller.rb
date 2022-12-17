class Users::EndpointGroupsController < Users::UsersApiController
  before_action :set_endpoint_group, only: %i[ show update destroy ]
  before_action :authenticate_user!

  def index
    begin   
      endpoint_groups = EndpointGroup.where(company_id: current_company.id, creator_type: 1).and(EndpointGroup.where(creator_type: 0))
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
    begin
      if check_subscription_limit?
        endpoint_group = EndpointGroup.new(endpoint_group_params)
        endpoint_group.company_id = current_company.id; endpoint_group.creator_id = current_user.id
        if endpoint_group.save!
          render json: {
            status: 200,
            endpoint_group: EndpointGroupSerializer.new(endpoint_group).serializable_hash[:data][:attributes]
          }
        end
      else
        render json: {status: 500, message: "You Have Reached Your Endpoint Groups Limit!"}
      end
  rescue => e
    render json: {status: 500, message: e.message}
  end
  end

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

    def check_subscription_limit?
      if current_company.subscription.present?
        endpointGroupsCount = current_company.endpoint_groups.count
        endpointGroupsLimit = current_company.subscription.package.endpoint_groups_creating_liumit
        !(endpointGroupsCount >=endpointGroupsLimit)
      end
    end
    def set_endpoint_group
      begin
          @endpoint_group = EndpointGroup.find(params[:id])
      rescue => e
        render json: {status: 500, message: e.message}
      end
    end

    def endpoint_group_params
      params.require(:endpoint_group).permit(:name, :description, :endpoint_type, :creator_id, :company_id, :creator_type)
    end
end
