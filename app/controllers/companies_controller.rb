class CompaniesController < ApplicationController

  def show
    id = params[:id]
    @company = Company.find(id)
    @products = @company.products
  end

  def index
    @companies = Company.all
  end
 # def initialize
    
 # end

  def new
    # default: render 'new' template
  end

  def create
    if company_params[:password].length > 7
      begin
        new_params = company_params
        new_params[:password] = Digest::MD5.hexdigest(new_params[:password])
        new_params[:approved] = true
        @company = Company.create!(new_params)
        flash[:success] = "#{@company.name} was successfully created. Please login below."
        redirect_to merchant_login_path
      rescue => err
        flash[:warning] = "#{err}"
        if flash[:warning].include? "username_UQ"
          flash[:warning] = "That username already exists. Please try a different one."
        end
        redirect_to new_company_path
      end
    else
      flash[:warning] = "Password must be at least 8 characters long"
      redirect_to new_company_path
    end
  end

  def edit
    @company = Company.find params[:id]
  end

  def update
    begin
      @company = Company.find params[:id]
      @company.update(company_params)
      flash[:notice] = "#{@company.name} was successfully updated."
      redirect_to company_path(@company)
    rescue => err
      flash[:notice] = "Error updating: #{err}"
      puts "ERROR: #{err}"
      redirect_to companies_path
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    flash[:notice] = "Product '#{@company.name}' deleted."
    redirect_to companies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def company_params
    params.require(:company).permit(:name, :description, :address, :image_url, :email, :password, :username)
  end
end
