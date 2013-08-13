class ContactsController < ApplicationController
  
  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      redirect_to coming_soon_path, notice: "Thank you for signing up. You will be notified of our release!"
    else
      render template: "static_pages/coming_soon"
    end
  end
end
