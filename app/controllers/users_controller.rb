class UsersController < ApplicationController

  def show
  end

  def index
  end
 # def initialize
    
 # end

  def new
    # default: render 'new' template
  end

  def create
    puts "#{user_params.inspect}"
    if user_params[:password].length > 7
      begin
        new_params = user_params
        new_params[:password] = Digest::MD5.hexdigest(new_params[:password])
        @user = User.create!(new_params)
        flash[:success] = "#{@user.username} was successfully created. Please login below."
        redirect_to new_user_path
      rescue => err
        flash[:warning] = "#{err}"
        if flash[:warning].include? "username_UQ"
          flash[:warning] = "That username already exists. Please try a different one."
        end
        redirect_to new_user_path
      end
    else
      flash[:warning] = "Password must be at least 8 characters long"
      redirect_to new_user_path
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def user_params
    params.require(:user).permit(:username, :fname, :lname, :password)
  end
end
