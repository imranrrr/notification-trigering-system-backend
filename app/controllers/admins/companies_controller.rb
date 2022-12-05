class Admins::CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show update destroy ]

  def index
    @companies = Company.all

    render json: @companies
  end

  def show
    render json: @company
  end

  def create
    byebug
    @company = Company.new(company_params)
    if @company.save! && user_params.present?
      user = User.create!(user_params)
     @company.update!(user_id: user.id)
     @company.user.update!(role: 2)
      render json: {
        status: 200,
        company: CompanySerializer.new(@company).serializable_hash[:data][:attributes]
      }
    end
  end

  def update
    if @company.update(company_params)
      render json: @company
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @company.destroy
  end

  private
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :sub_domain)
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, role: 2)
    end
end
