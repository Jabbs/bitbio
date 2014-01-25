class FacilitiesController < ApplicationController
  if Rails.env.production?
    http_basic_authenticate_with :name => "bitbio", :password => "bitbio"
  end
  before_filter :signed_in_user, except: [:index]
  before_filter :verified_user, except: [:index]
  
  def index
    @facility = Facility.new
    @facility.build_location
    @facilities = Facility.order("id ASC").paginate(page: params[:page], per_page: 100)
    @facilities_off_map = Facility.order("id ASC").joins(:location).where(locations: {display_on_map: false}).paginate(page: params[:page], per_page: 100)
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
      redirect_to facilities_path, notice: "Facility has been submitted."
    else
      render 'index'
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
    
    def verified_user
      redirect_to current_user, alert: 'Please verify your account first.' unless current_user.verified
    end
end
