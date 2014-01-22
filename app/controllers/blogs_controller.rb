class BlogsController < ApplicationController
  before_filter :signed_in_user, except: [:index, :show]
  before_filter :verified_user, except: [:index, :show]
  before_filter :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @blogs = Blog.scoped.order("created_at DESC").paginate(page: params[:page], per_page: 9)
  end
  
  def show
    @blog = Blog.find(params[:id])
    @blog.add_view_count unless current_user?(@blog.user) || admin_user?
    @comment = @blog.comments.new
    @comments = @blog.comments.roots.order("created_at ASC")
    @commentable = @blog
    if request.path != blog_path(@blog)
      redirect_to @blog, status: :moved_permanently
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "The blog you attempted to view is no longer available."
  end
  
  def new
    @blog = current_user.blogs.build
  end
  
  def create
     @blog = current_user.blogs.build(params[:blog])
    create_tags
    if @blog.save
      create_bitly_url(blog_url(@blog)) if Rails.env.production? && ENV['STAGING'].nil?
      redirect_to @blog, notice: "Your blog entry has been created!"
    else
      render 'new'
    end
  end
  
  def edit
    @blog = Blog.find(params[:id])
  end
  
  def update
    @blog = Blog.find(params[:id])
    if @blog.update_attributes(params[:blog])
      create_tags
      @blog.save!
      redirect_to @blog, notice: 'Blog was successfully updated.'
    else
      render action: "edit"
    end
  end
  
  private
    
    def create_bitly_url(long_url)
      bitly = Bitly.client
      u = bitly.shorten(long_url)
      @blog.bitly_url = u
      @blog.save!
    end

    def create_tags
      tag_list = params["hidden-blog"]["tag_list"].split(',')
      tag_list.each do |tag|
        unless tag == 'bitbio'
          if Tag.find_by_name(tag)
            t = Tag.find_by_name(tag)
          else
            t = Tag.create!(name: tag)
          end
          @blog.taggings.build(tag_id: t.id)
        end
      end
    end

    def verified_user
      redirect_to current_user, alert: 'Please verify your account first.' unless current_user.verified
    end

    def correct_user
      @blog = Blog.find(params[:id])
      redirect_to root_path unless current_user?(@blog.user) || current_user.admin?
    end

    def signed_in_user_go_to_dash
      if current_user
        redirect_to root_path
      end
    end
end
