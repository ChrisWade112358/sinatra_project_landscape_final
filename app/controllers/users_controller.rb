class UsersController < ApplicationController
      
    get '/users' do
        if current_user && current_user.name == ENV.fetch("ADMIN")
            @users= User.all
            erb :'/users/index'
        else
            puts "1. You do not have access to this information"
            redirect '/'
        end
        
    end

    get '/users/new' do 
        if current_user && current_user.name == ENV.fetch("ADMIN")
            erb :'/users/new'
        else
            puts "2. You do not have access to this information"
            redirect '/'
        end
    end

    get '/users/:id' do
        @user = User.find_by_id(params[:id])
        @enquiry = Enquiry.all
        if @user
            erb :'/users/show'
        else
            redirect "/users"
        end
    end

    get '/users/:id/edit' do 
        @user = User.find_by_id(params[:id])
       
        if current_user
            erb :'/users/edit'
        else
            redirect "/users"
        end
    end

    post '/users' do
        if validate_both_email == false
            @user = User.create(params)
            @user.employee = true
            if @user.save
                redirect "/users/#{@user.id}"
            else
                puts "User Record Not Created Please Try Again"
                redirect "/users/new"
            end
        else
            puts "Email already exsists"
                redirect "/users/new"
        end
    end

    patch '/users/:id' do
        if validate_both_email == false
            @user = current_user
            @user.update(name: params[:name], email: params[:email], username: params[:username], password: params[:password])
            if @user.save
                puts "user updated!!"
                redirect "/users/#{@user.id}"
            else
                puts "user not updated!!!"
                redirect "/users/#{@user.id}/edit"
            end
        else
            @user = current_user
            puts "email already exsists"
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
        if current_user.employee == true
            @customers= Customer.all
            erb :'/customers/index'
        else
            puts "3. You do not have access to this information"
            redirect '/'
        end
    end
end