class UsersController < ApplicationController
      
    get '/users' do
        if current_user && current_user.password == ENV.fetch("ADMIN")
            @users= User.all
            erb :'/users/index'
        else
            puts "1. You do not have access to this information"
            erb :welcome
        end
        
    end

    get '/users/new' do 
        if current_user && current_user.password == ENV.fetch("ADMIN")
            erb :'/users/new'
        else
            puts "2. You do not have access to this information"
                erb :welcome
        end
    end

    get '/users/:id' do
        @user = current_user
        if @user
            erb :'/users/show'
        else
            redirect "/users"
        end
    end

    get '/users/:id/edit' do 
        @user = current_user
        if @user && current_user.password == ENV.fetch("ADMIN")
            erb :'/users/edit'
        else
            redirect "/users"
        end
    end

    post '/users' do
        @user = User.create(params)
        @user.employee = true
        if @user.save
            redirect "/users/#{@user.id}"
        else
            puts "User Record Not Created Please Try Again"
            redirect "/users/new"
        end
    end

    patch '/users/:id' do
        @user = current_user
        @user.update(name: params[:name], email: params[:email], username: params[:username], password: params[:password])
        if @user.save
            binding.pry
            puts "user updated!!"
            redirect "/users/#{@user.id}"
        else
            puts "user not updated!!!"
            redirect "/users/#{@user.id}/edit"
        end
    end

    delete '/users/:id' do
        user = User.find_by_id(params[:id])
        if user && current_user.password == ENV.fetch("ADMIN")
            user.delete
        end
        redirect '/logout'
    end

    get '/customers' do
        if current_user && session[:password_digest] == ENV.fetch("ADMIN")
            @customers= Customer.all
            erb :'/customers/index'
        else
            puts "3. You do not have access to this information"
            erb :welcome
        end
    end
end