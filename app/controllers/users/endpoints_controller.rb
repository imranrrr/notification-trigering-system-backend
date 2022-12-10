class Users::EndpointsController < Users::UsersApiController
  before_action :set_endpoint, only: %i[ show update destroy ]
  before_action :authenticate_user!

  def index
    begin
      default_endpoints = Endpoint.where(creator_type: 0)
      user_endpoints = Endpoint.where(company_id: current_company.id, creator_type: 1)
      endpoints = default_endpoints + user_endpoints
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
    @endpoint.company_id = current_company.id; @endpoint.creator_id = current_user.id
    if destination_params.present?
      @destination = Destination.new(destination_params)
      @destination.company_id = current_company.id; @destination.creator_id = current_user.id;
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
          destination.company_id = current_company.id; destination.creator_id = current_user.id;
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
            status: 200,
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
