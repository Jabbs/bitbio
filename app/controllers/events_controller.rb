class EventsController < ApplicationController
  before_filter :signed_in_user, except: [:index, :show]
  before_filter :verified_user, except: [:index, :show]
  before_filter :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @events = Event.scoped.order("created_at DESC").paginate(page: params[:page], per_page: 9)
  end
  
  def show
    @event = Event.find(params[:id])
    @event.add_view_count unless current_user?(@event.user)
    @comment = @event.comments.new
    @comments = @event.comments.order("created_at ASC")
    @commentable = @event
    if request.path != event_path(@event)
      redirect_to @event, status: :moved_permanently
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "The event you attempted to view is no longer available."
  end
  
  def new
    @event = current_user.events.build
    @event.build_location
    @event.attachments.build
  end
  
  def create
     @event = current_user.events.build(params[:event])
    create_tags
    if @event.save
      create_bitly_url(event_url(@event)) if Rails.env.production? && ENV['STAGING'].nil?
      redirect_to @event, notice: "Your event entry has been created!"
    else
      @event.attachments.build
      render 'new'
    end
  end
  
  def edit
    @event = Event.find(params[:id])
    @event.attachments.build
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      @event.attachments.order('created_at DESC').last.destroy if params[:event][:_destroy] == '1'
      create_tags
      @event.save!
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render action: "edit"
    end
  end
  
  private
    
    def create_bitly_url(long_url)
      bitly = Bitly.client
      u = bitly.shorten(long_url)
      @event.bitly_url = u
      @event.save!
    end

    def create_tags
      tag_list = params["hidden-event"]["tag_list"].split(',')
      tag_list.each do |tag|
        unless tag == 'bitbio'
          if Tag.find_by_name(tag)
            t = Tag.find_by_name(tag)
          else
            t = Tag.create!(name: tag)
          end
          @event.taggings.build(tag_id: t.id)
        end
      end
    end

    def verified_user
      redirect_to current_user, alert: 'Please verify your account first.' unless current_user.verified
    end

    def correct_user
      @event = Event.find(params[:id])
      redirect_to root_path unless current_user?(@event.user) || current_user.admin?
    end

    def signed_in_user_go_to_dash
      if current_user
        redirect_to root_path
      end
    end
end
