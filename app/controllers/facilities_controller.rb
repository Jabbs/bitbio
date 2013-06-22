class FacilitiesController < ApplicationController
  
  def index
    @locations = Location.facilities
    @json = @locations.to_gmaps4rails do |location, marker|
      marker.infowindow render_to_string(partial: "/facilities/info_window", locals: { location: location })
      marker.title "#{location.locationable.name}"
      marker.json({ :id => location.id})
    end
  end
  
  def show
  end
  
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
end
