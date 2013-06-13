class ServicesController < ApplicationController
  before_filter :signed_in_user, except: [:index, :show]
  before_filter :verified_user, except: [:index, :show]
  before_filter :check_if_private_or_locked_or_inactive, only: [:show]
  before_filter :correct_user, only: [:edit, :update, :destroy]
  
  def index
  end
  
  def show
  end
  
  def new
    @service = Service.new
  end
  
  def edit
    @service = Service.find(params[:id])
  end
  
  def update
    @service = Service.find(params[:id])
    if @service.update_attributes(params[:service])
      create_tags
      @service.save!
      check_if_searchable
      redirect_to @service, notice: 'service was successfully updated.'
    else
      render action: "edit"
    end
  end
  
  def create
    @service = Service.new(params[:service])
    @service.user = current_user
    create_tags
    if @service.save
      create_bitly_url(service_url(@service)) if in_production?
      check_if_searchable
      redirect_to @service, notice: "Your service listing has now been activated!"
    else
      render 'new'
    end
  end
  
  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    
    redirect_to user_service_listings_path(current_user), alert: "Your service has been removed."
  end
  
  private
    
    def create_bitly_url(long_url)
      bitly = Bitly.client
      u = bitly.shorten(long_url)
      @service.bitly_url = u
      @service.save!
    end
    
    def create_tags
      tag_list = params["hidden-service"]["tag_list"].split(',')
      tag_list.each do |tag|
        unless tag == 'bitbio'
          if Tag.find_by_name(tag)
            t = Tag.find_by_name(tag)
          else
            t = Tag.create!(name: tag)
          end
          @service.taggings.build(tag_id: t.id)
        end
      end
    end
    
    def check_if_searchable
      @service.visability == 'locked' ? @service.searchable = false : @service.searchable = true
      @service.save
    end
    
    def check_if_private_or_locked_or_inactive
      @service = Service.find(params[:id])
      if @service.inactive?
        unless current_user && current_user?(@service.user)
          redirect_to root_path, alert: "The service you tried to view is no longer active." unless current_user && current_user.admin?
        end
      elsif @service.visability == 'private'
        unless current_user && current_user.verified
          redirect_to root_path, alert: "This service is only viewable to verified bitBIO members. Please sign up or log in to view this service."
        end
      elsif @service.visability == 'locked'
        unless current_user && current_user.verified && current_user?(@service.user)
          redirect_to root_path, alert: "This service is has been locked by the owner and is not currently viewable." unless current_user && current_user.admin?
        end
      end
    end
    
    def verified_user
      redirect_to current_user, alert: 'Please verify your account first.' unless current_user.verified
    end
    
    def correct_user
      @service = Service.find(params[:id])
      redirect_to root_path unless current_user?(@service.user) || current_user.admin?
    end
    
    def signed_in_user_go_to_dash
      if current_user
        redirect_to root_path
      end
    end
  
end
