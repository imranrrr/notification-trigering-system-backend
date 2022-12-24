class Admins::CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show update destroy company_users ]
  before_action :authenticate_admin!

  def index
    begin
      @companies = Company.all
      render json: {
          status: 200,
          companies: CompanySerializer.new(@companies).serializable_hash[:data].map{|data| data[:attributes]}
        }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def show
    begin
      render json: {
          status: 200,
          company: CompanyUpdateSerializer.new(@company).serializable_hash[:data][:attributes]
        }
      rescue => e
        render json: {status: 500, message: e.message}
      end
  end

  def create
    begin
      @company = Company.new(company_params)
      @company.admin_id = current_admin.id
      if @company.save!
        render json: {
          status: 200,
          company: CompanySerializer.new(@company).serializable_hash[:data][:attributes]
        }
      end
    rescue => e 
      render json: {status: 500, message: e.message}
    end
  end

  def update
    begin
      if company_params[:logo].present? && company_params[:logo].to_s.include?("UploadedFile")
          @company.update!(company_params)
      else
          @company.update!(company_params.except(:logo))
      end
      render json: {
            status: 200,
            company: CompanySerializer.new(@company).serializable_hash[:data][:attributes]
        }
    rescue => e 
      render json: {status: 500, message: e.message}
    end
  end


  def destroy
    begin
      @company.destroy
      render json: {
        status: 200,
        company: @company 
      }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def company_users
    begin
      users = User.where(company_id: @company.id)
      render json: {
        status: 200,
        company_users: UserSerializer.new(users).serializable_hash[:data].map{|data| data[:attributes]}
      }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  private
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params[:status] = params[:status].to_i
      params.permit(:id, :name, :sub_domain, :okta_sso_login, :logo, :status)
    end
end
