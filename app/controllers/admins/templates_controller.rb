class Admins::TemplatesController < ApplicationController
  before_action :set_template, only: %i[ show update destroy ]
  respond_to :json

  def index
    begin
      templates = Template.all.order("created_at DESC")
      render json: {
          templates: TemplateSerializer.new(templates).serializable_hash[:data].map{|data| data[:attributes]}
        }
    rescue => e
      render json: e.message
    end
  end

  def show
    begin
      render json: {
        template: TemplateSerializer.new(@template).serializable_hash[:data][:attributes]
      }
    rescue => e
      render json: e.message
    end
  end

  def create
    @template = Template.new(template_params)
    begin
      if @template.save!
        render json: {
          template: TemplateSerializer.new(@template).serializable_hash[:data][:attributes]
        }
      end
    rescue => e
      render json: e.message
    end
  end

  def update
    begin
    @template.update!(template_params)
       render json: {
           template: TemplateSerializer.new(@template).serializable_hash[:data][:attributes]
         }
    rescue => e
      render json: e.message
    end
  end

  def destroy
    begin
      render json: {
        message: "you just destroyed! tmeplate.",
        template: @template
      }
      @template.destroy
    rescue => e
      render json: e.message
    end
  end

  private
    def set_template
      begin
        @template = Template.find(params[:id])
      rescue => e
        render json: e.message
      end
    end

    def template_params
      if params[:audio].to_s.include? "UploadedFile"
        params.permit(:id, :name, :subject, :body, :audio, :font_color, :user_id, :background_color, :admin_id )
      else
        params.permit(:id, :name, :subject, :body, :font_color, :user_id, :background_color, :admin_id )
      end
    end
end
