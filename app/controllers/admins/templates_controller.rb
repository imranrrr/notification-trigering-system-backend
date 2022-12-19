class Admins::TemplatesController < ApplicationController
  before_action :set_template, only: %i[ show update destroy ]
  before_action :authenticate_admin!
  respond_to :json

  def index
    begin
      templates = Template.all.order("created_at DESC")
      render json: {
          status: 200,
          templates: TemplateSerializer.new(templates).serializable_hash[:data].map{|data| data[:attributes]}
        }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def show
    begin
      render json: {
        status: 200,
        template: TemplateSerializer.new(@template).serializable_hash[:data][:attributes]
      }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def create
    @template = Template.new(template_params)
    @template.admin_id = current_admin.id; @template.creator_type = 0
    begin
      if @template.save!
        render json: {
          status: 200,
          template: TemplateSerializer.new(@template).serializable_hash[:data][:attributes]
        }
      end
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def update
    begin
      if template_params[:audio].present? && template_params[:audio].to_s.include?("UploadedFile")
          @template.update!(template_params)
      else
          @template.update!(template_params.except(:audio))
      end
      render json: {
           status: 200,
           template: TemplateSerializer.new(@template).serializable_hash[:data][:attributes]
         }
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  def destroy
    begin
      render json: {
        status: 200,
        template: @template
      }
      @template.destroy
    rescue => e
      render json: {status: 500, message: e.message}
    end
  end

  private
    def set_template
      begin
        @template = Template.find(params[:id])
      rescue => e
        render json: {status: 500, message: e.message}
      end
    end

    def template_params
          params.permit(:id, :name, :subject, :body, :audio, :font_color, :admin_id, :background_color)
    end
end
