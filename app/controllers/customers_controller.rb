class UsersController < ApplicationController
   
    get '/customers/new' do
        erb :'/customers/new'
    end

    get '/customers/:id' do
        @customer = Customer.find_by_id(params[:id])
        if @customer 
            erb :'/customers/show'
        else
            if employee
                erb :'customers/show'
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
        if validate_both_email == false
            customer = Customer.create(params)
            if customer.save
                session[:customer_id] = customer.id
                redirect '/enquiries/new'
            else
                puts "User Record Not Created Please Try Again"
                redirect "/customers/new"
            end
        else
            puts "email matches exsisting email"
            redirect "/customers/new"
        end
    end

    patch '/customers/:id' do
        if validate_both_email == false
            @customer = current_customer
            if @customer.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], address: params[:address], state: params[:state], zip: params[:zip], password: params[:password])
                puts "Customer EDITED!!!"
                redirect "/customers/#{@customer.id}"
            else
                puts "COUSTOMER NOT EDITED!!!!!"
                redirect "/customers/#{@customer.id}/edit"
            end
        else
            @customer = current_customer
            puts "email already exsists"
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