class UsersController < ApplicationController
   
    get '/customers/new' do
        erb :'/customers/new'
    end

    get '/customers/:id' do
        @customer = current_customer
        employee = session[:employee] == true

        if @customer 
            erb :'/customers/show'
        else
            if employee
                erb :'customer/show'
            else  
                redirect "/"
            end
        end
    end

    get '/customers/:id/edit' do 
        @customer = current_customer
        managment = session[:password_digest] == ENV.fetch("ADMIN")
        if @customer || managment
            erb :'/customers/edit'
        else
            redirect "/"
        end
    end

    post '/customers' do
        customer = Customer.create(params)
        session[:customer_id] = customer.id
        session[:email] = customer.email
        binding.pry
        if customer
            redirect '/enquiries/new'
        else
            puts "User Record Not Created Please Try Again"
            redirect "/customers/new"
        end
    end

    patch '/customers/:id' do
        @customer = current_customer
        binding.pry
        if @customer.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], address: params[:address], state: params[:state], zip: params[:zip], password: params[:password])
            puts "Customer EDITED!!!"
            redirect "/customers/#{@customer.id}"
        else
            puts "COUSTOMER NOT EDITED!!!!!"
            redirect "/customers/#{@customer.id}/edit"
        end
    end

    delete '/customers/:id' do
        customer = current_customer
        if customer
            customer.delete
        end
        redirect '/logout'
    end
end