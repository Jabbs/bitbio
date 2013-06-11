module ApplicationHelper
  
  def in_production?
    if Rails.env.production? && ENV['STAGING'].nil?
      true
    else
      false
    end
  end
  
  def in_staging?
    if Rails.env.production? && ENV['STAGING'].present?
      true
    else
      false
    end
  end
  
  def in_development?
    if Rails.env.development?
      true
    else
      false
    end
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    @id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: @id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: @id, fields: fields.gsub("\n", "")})
  end
  
  def resource_header(url)
    elements = url.split('/')[1..-1]
    if elements && elements.size == 2 && elements[1] != 'new'
      elements[0]
    elsif elements && elements[2] == 'comments'
      elements[1]
    elsif elements
      elements[0] if elements[0] == 'tags' || elements[0] == 'projects' || elements[0] == 'blogs'
    end
  end
  
  def is_liked?(item)
    if current_user && item.likes.where(user_id: current_user.id).any?
      true
    else
      false
    end
  end
  
  def bread_crumb_list_items(url)
    elements = url.split('/')[1..-1]
    c = content_tag(:span, " / ")
    home = content_tag(:li, link_to('home', root_path))
    
    crumbs = []
    
    if elements
      if elements[2]
        crumbs << home; crumbs << c;
        crumbs << content_tag(:li, link_to("#{elements[0].downcase}", "/#{elements[0].downcase}")); crumbs << c;
        crumbs << content_tag(:li, link_to("#{elements[1].downcase}", "/#{elements[0].downcase}/#{elements[1].downcase}")); crumbs << c;
        crumbs << content_tag(:li, "#{elements[2].titleize}", class: 'active')
      elsif elements[1]
        crumbs << home; crumbs << c;
        crumbs << content_tag(:li, link_to("#{elements[0].downcase}", "/#{elements[0].downcase}")); crumbs << c;
        if elements[1] == 'new'
          crumbs << content_tag(:li, "#{elements[1].titleize} #{elements[0].singularize.titleize}", class: 'active')
        else
          crumbs << content_tag(:li, "#{elements[1].titleize}", class: 'active')
        end
      else
        crumbs << home; crumbs << c;
        crumbs << content_tag(:li, "#{elements[0].titleize}", class: 'active')
      end
      
    else
      crumbs << home; crumbs << c;
      crumbs << content_tag(:li, "bitBIO", class: 'active')
    end
    
    crumbs.each {|item| concat(content_tag(:li, item))}
    return
  end
  
end
