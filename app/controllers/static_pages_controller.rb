class StaticPagesController < ApplicationController
  def coming_soon
    @contact = Contact.new
  end
end
