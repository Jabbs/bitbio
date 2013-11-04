class StaticPagesController < ApplicationController
  def coming_soon
    @contact = Contact.new
  end
  
  def about
  end
  
  def how_it_works
  end
  
  def privacy
  end
  
  def terms
  end
  
  def press
  end
end
