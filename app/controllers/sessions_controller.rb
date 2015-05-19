class SessionsController < ApplicationController
def new
 # displays the login form
 
end
 
def create
user = User.find_by(username: params[:username])
if user && user.authenticate(params[:password])
session[:user_id] = user.id # save user_id and not an object
flash[:notice] = "You've logged in successfully. Welcome."
redirect_to root_path
else
flash[:error] = "Your username or e-mail is incorrect"
redirect_to register_path 
 end
end
 
 
def destroy
session[:user_id] = nil
flash[:notice] = "You have logged out"
redirect_to root_path 
 
end
 
 
end