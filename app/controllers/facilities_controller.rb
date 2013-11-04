class FacilitiesController < ApplicationController
  http_basic_authenticate_with :name => "bitbio", :password => "bitbio"
  before_filter :admin_user, except: [:index]
  
  def index
    @facilities = Facility.order("id ASC").paginate(page: params[:page], per_page: 100)
    @locations = Location.geocoded.facilities.where(display_on_map: true)
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
    if @facility.users.any?
      redirect_to facilities_path, alert: "Cannot destroy a facility that has users."
    else
      @facility.destroy
      redirect_to facilities_path, alert: "Facility has been removed."
    end
  end
  
  private
    def admin_user
      redirect_to(root_path) unless current_user && current_user.admin?
    end
end
