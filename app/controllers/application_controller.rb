require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV.fetch("SECRET")

    
  end

  get "/" do
    erb :welcome
  end

  helpers do
    
    def logged_in?
      !!session[:user_id]
    end

    def logged_in_customer?
      !!session[:customer_id]
    end

    def current_user
      @user ||= User.find_by_id(session[:user_id]) if logged_in? 
    end

    def current_customer
      @customer = Customer.find_by_id(session[:customer_id]) if logged_in_customer?
      
    end

  end

end
