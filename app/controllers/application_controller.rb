class ApplicationController < ActionController::Base
  if Rails.env.production? && ENV['STAGING'] == "true"
    http_basic_authenticate_with :name => "bitbio", :password => "bitbio"
  end
  before_filter :ensure_domain
  before_filter :instantiate_message_and_user
  protect_from_forgery
  include SessionsHelper
  include ApplicationHelper
  
  APP_DOMAIN = 'www.bitbio.org'
  
  def ensure_domain
    if (Rails.env.production? && request.env['HTTP_HOST'] != APP_DOMAIN) && ENV['STAGING'].nil?
      # HTTP 301 is a "permanent" redirect
      redirect_to "http://#{APP_DOMAIN}", :status => 301
    end
  end
  
  def instantiate_message_and_user
    @message = Message.new
    @signup_user = User.new
    @session_user = User.new
    @forgot_pass_user = User.new
  end
end
