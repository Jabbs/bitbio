module ApplicationHelper
  require 'will_paginate/collection'
  Array.class_eval do
    def paginate(options = {})
      raise ArgumentError, "parameter hash expected (got #{options.inspect})" unless Hash === options

      WillPaginate::Collection.create(
          options[:page] || 1,
          options[:per_page] || 30,
          options[:total_entries] || self.length
      ) { |pager|
        pager.replace self[pager.offset, pager.per_page].to_a
      }
    end
  end
  
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
  
  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
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
    unless elements && elements.include?('new')
      if elements && elements.size == 2 && elements[1] != 'new'
        elements[0]
      elsif elements
        elements[0] if elements[0] == 'tags' || elements[0] == 'events' || elements[0] == 'projects' || elements[0] == 'blogs' || elements[0] == 'services' || elements[0] == 'facilities'
      end
    end
  end
  
  def get_request_country
    if request.location && request.location.country == "United States"
      @country = "United States of America"
    else
      @country = ""
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
    c = content_tag(:span, "<i class='icon-caret-right' style='padding-right:3px;padding-left:3px;'></i>".html_safe)
    home = content_tag(:li, link_to('home', root_path))
    
    crumbs = []
    
    if elements
      if elements[2]
        crumbs << home; crumbs << c;
        crumbs << content_tag(:li, link_to("#{elements[0].downcase}", "/#{elements[0].downcase}")); crumbs << c;
        crumbs << content_tag(:li, link_to("#{elements[1].downcase}", "/#{elements[0].downcase}/#{elements[1].downcase}")); crumbs << c;
        crumbs << content_tag(:li, "#{elements[2].downcase}", class: 'active')
      elsif elements[1]
        crumbs << home; crumbs << c;
        crumbs << content_tag(:li, link_to("#{elements[0].downcase}", "/#{elements[0].downcase}")); crumbs << c;
        if elements[1] == 'new'
          crumbs << content_tag(:li, "#{elements[1].downcase} #{elements[0].singularize.downcase}", class: 'active')
        else
          crumbs << content_tag(:li, "#{elements[1].downcase}", class: 'active')
        end
      else
        crumbs << home; crumbs << c;
        crumbs << content_tag(:li, "#{elements[0].downcase}", class: 'active')
      end
      
    else
      crumbs << home; crumbs << c;
      crumbs << content_tag(:li, "BitBio", class: 'active')
    end
    
    crumbs.each {|item| concat(content_tag(:li, item))}
    return
  end
  
  
  
end
