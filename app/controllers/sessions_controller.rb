class SessionsController < ApplicationController

    
    get '/login' do
        erb :"sessions/login"
    end

    post '/login' do
        user = User.find_by(email: params[:email]) 
        customer = Customer.find_by(email: params[:email])
       

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            session[:email] = user.email
            session[:employee] = user.employee
            puts "You are Logged in"
            redirect "/users/#{user.id}"
        else
            if customer && customer.authenticate(params[:password])
                session[:customer_id] = customer.id
                puts "You ARE Logged in"
                
                redirect "/customers/#{customer.id}"
            else
                puts "You are NOT Logged in"
                redirect '/'
            end
        end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end
end