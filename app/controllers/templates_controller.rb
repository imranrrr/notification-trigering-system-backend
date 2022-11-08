class TemplatesController < ApplicationController
  before_action :set_template, only: %i[ show update destroy ]
  respond_to :json

  # GET /templates
  def index
    templates = Template.all.order("created_at DESC")
    render json: {
        templates: TemplateSerializer.new(templates).serializable_hash[:data].map{|data| data[:attributes]}
      }
  end

  # GET /templates/1
  def show
      render json: {
        template: TemplateSerializer.new(@template).serializable_hash[:data][:attributes]
      }
  end

  # POST /templates
  def create
    @template = Template.new(template_params)
    if @template.save!
      render json: {
        template: TemplateSerializer.new(@template).serializable_hash[:data][:attributes]
      }
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /templates/1
  def update
    if @template.update(template_params)
      render json: @template
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  # DELETE /templates/1
  def destroy
    @template.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Template.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def template_params
      params.require(:template).permit(:name, :subject, :body, :audio, :font_color, :user_id, :background_color )
    end
end
