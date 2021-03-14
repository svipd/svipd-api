class CompaniesController < ApplicationController

  def show
    id = params[:id]
    @company = Company.find(id)
    @products = @company.products
  end

  def index
    @companies = Company.all
    company_to_user_by_distance(5)
  end

  def company_to_user_by_distance(user_id)
    # Add the following to the user load:
    # geocoded_by :ip_address,
    # :latitude => :lat, :longitude => :lon
    # after_validation :geocode
    @companies = Company.all
    temp_user_address = '4200 Fifth Ave, Pittsburgh, PA 15260'
    user_addr=Geokit::Geocoders::GoogleGeocoder.geocode temp_user_address
    @distances = Array.new
    @companies.each do |c|
      if c.address.nil? == false
        distance = Hash.new
        distance["company_id"] = c.company_id
        dist = user_addr.distance_to(c.address)
        distance["distance"] = dist
        @distances << distance
      end
    end
    @distances = @distances.sort_by { |hsh| hsh[:distance] }
    @distances
  end

  def get_distance(from, to)
    from.distance_to(to)
  end
 # def initialize
    
 # end

  def new
    # default: render 'new' template
  end

  def create
    begin
      @company = Company.create!(company_params)
      flash[:notice] = "#{@company.name} was successfully created."
      redirect_to companies_path
    rescue => err
      flash[:notice] = "Error creating: #{err}"
      redirect_to companies_path
    end
  end

  def edit
    @company = Company.find params[:id]
  end

  def update
    begin
      @company = Company.find params[:id]
      @company.update_attributes!(company_params)
      flash[:notice] = "#{@company.name} was successfully updated."
      redirect_to company_path(@company)
    rescue => err
      flash[:notice] = "Error updating: #{err}"
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
    params.require(:company).permit(:name, :description, :longitude, :latitude)
  end
end
