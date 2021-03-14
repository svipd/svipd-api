class HomeController < ApplicationController
  
  def index
      
      @storiess = Story.last(10).reverse 
  end
   
    
  def login
      
  end
   
    
  def home_login
    user_login_name = params['myform']
    puts "The name of the merchant is"
    puts user_login_name

    @user_existing = Company.all
    @user_exists = @user_existing.exists?(:name => user_login_name)
    if @user_exists == true
      @story = Company.find_by(name: user_login_name)
    else
      redirect_to home_path
    end
  end   
  def stories_paths
       @story = Story.new
       @stor = Company.find(params[:id])
       
       puts "\n\n\n\n\n"
       puts @story.company_id
       puts "\n\n\n\n"
       
  end
    
  
    
end
