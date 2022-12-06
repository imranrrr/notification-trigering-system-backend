class Admins::CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show update destroy ]

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
          company: CompanySerializer.new(@company).serializable_hash[:data][:attributes]
        }
      rescue => e
        render json: {status: 500, message: e.message}
      end
  end

  def create
    begin
      @company = Company.new(company_params)
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
      if @company.update!(company_params)
        render json: {
          status: 200,
          company: Companyserializer.new(@company).serializable_hash[:data][:attributes]
      }
      end
    rescue => e 
      render json: {status: 500, message: e.message}
    end
  end


  def destroy
    begin
      @company.destroy
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  private
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :sub_domain, :okta_sso_login)
    end
end
