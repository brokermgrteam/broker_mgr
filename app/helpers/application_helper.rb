# encoding: utf-8
module ApplicationHelper
  
  #return title
  def title 
    base_title = "营销综合管理"
    if @title.nil?
      base_title
    else 
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    image_tag("logo_ht.png", :alt => "营销综合管理" )
    # "海通证券"
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "btn btn-info add_fields pull-right", data: {id: id, fields: fields.gsub("\n", "")})
  end
end
