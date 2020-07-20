class EnquiriesController < ApplicationController


    get '/enquiries' do
        if current_user
            @user = current_user
            @enquiry = Enquiry.all
            erb :'users/enquiries/index'
        else
            puts "1. You do not have access to this information"
            erb :welcome
        end
        
    end

    get '/enquiries/new' do 
        binding.pry
        if current_customer
            erb :'/enquiries/new'
        else
            puts "2. You do not have access to this information"
            erb :welcome
        end
    end

    get '/enquiries/:id' do
        @enquiry = Enquiry.find_by_id(params[:id])
        if @enquiry.customer_id == session[:customer_id]
            erb :'/enquiries/show'
        else
            if @enquiry == session[:user_id]
                erb :'enquiries/show'
            else 
                puts "You DO NOT HAVE PERMISSION to ACCESS THIS Enquiry"              
                erb :welcome
            end
        end
    end

    get '/enquiries/:id/edit' do 
        @enquiry = Enquiry.find_by_id(params[:id])
        if @enquiry.customer_id == session[:customer_id]
            erb :'/enquiries/edit'
        else
            if @enquiry == session[:user_id]
                erb :'enquiries/edit'
            else 
                puts "You DO NOT HAVE PERMISSION to ACCESS THIS Enquiry"              
                erb :welcome
            end
        end
    end

    post '/enquiries' do
        @enquiry = Enquiry.create(params)
        binding.pry
        if session[:customer_id]
            @enquiry.customer_id = session[:customer_id]
            binding.pry
            redirect "/customers/#{@enquiry.customer_id}"
        else 
            puts "User Record Not Created Please Try Again"
            redirect "/customers/new"
            
           
        end 
              
        
    end

    patch '/users/:id' do
        @enquiry = Enquiry.find_by_id(params[:id])
        @enquiry.update(enquiry: params[:enquiry], user_id: params[:user_id])
        if @enquiry.customer_id && enquiry.save
            binding.pry
            puts "user updated!!"
            redirect "/customers/#{@enquiry.customer_id}"
        end 
        if @enquiry.user_id && enquiry.save
            binding.pry
            puts "user updated!!"
            redirect "/customers/#{@enquiry.customer_id}"
        end 
        if @enquiry.customer_id && !enquiry.save
            puts "user not updated!!!"
            redirect "/customers/#{@enquiry.customer_id}/edit"
        else
            puts "user not updated!!!"
            redirect "/users/#{@enquiry.user_id}/edit"
        end
    end

    delete '/enquiries/:id' do
        @enquiry = Enquiry.find_by_id(params[:id])
        if session[:customer_id]
            @enquiry.delete
            redirect "/customer/#{@enquiry.customer_id}"
        else
            @enquiry.delete
            redirect "/user/#{@enquiry.user_id}"
        end
        
    end

    
end