class FacilitiesController < ApplicationController
  
  def index
    @facilities = Facility.order("id ASC")
    @locations = Location.geocoded.facilities
    @json = @locations.to_gmaps4rails do |location, marker|
      marker.infowindow render_to_string(partial: "/facilities/info_window", locals: { location: location })
      marker.title "#{location.locationable.name}"
      marker.json({ :id => location.id})
    end
  end
  
  def show
  end
  
  def new
    @facility = Facility.new
    @facility.build_location
  end
  
  def create
    @facility = Facility.new(params[:facility])
    if @facility.save
      redirect_to facilities_path, notice: "Facility added."
    else
      render 'new'
    end
  end
  
  def edit
    @facility = Facility.find(params[:id])
  end
  
  def update
    @facility = Facility.find(params[:id])
    if @facility.update_attributes(params[:facility])
      redirect_to facilities_path, notice: 'Facility successfully updated.'
    else
      render action: "edit"
    end
  end
  
  def destroy
    @facility = Facility.find(params[:id])
    @facility.destroy
    
    redirect_to facilities_path, alert: "Facility has been removed."
  end
end
