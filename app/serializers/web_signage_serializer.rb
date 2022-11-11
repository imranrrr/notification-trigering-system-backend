class WebSignageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :scroller_speed, :landscape_title_width, :landscape_title_height, :landscape_title_top, :landscape_title_left, :landscape_description_width, :landscape_description_height, :landscape_description_top, :landscape_description_left, :potrait_title_width, :potrait_title_height, :potrait_title_top, :potrait_title_left, :potrait_description_width, :potrait_description_height, :potrait_description_top, :potrait_description_left
  
  attribute :created_at do |web_signage|
    web_signage && web_signage.created_at.strftime('%d/%m/%Y')
  end
end
