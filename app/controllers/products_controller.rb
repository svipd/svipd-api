class ProductsController < ApplicationController

  def show
    id = params[:id]
    @product = Product.find(id)
    @company = Company.find(@product.company_id)
  end

  def index
    search = params[:search]
    @products = Product.all
    if search != nil
      s = search["search"]
      @products = Product.where("name LIKE '%#{s}%' OR description LIKE '%#{s}%' ").order(:price)
    end
    a=Geokit::Geocoders::GoogleGeocoder.geocode '140 Market St, San Francisco, CA'
    puts "LOCATION: #{a}"
  end
 # def initialize
    
 # end

  def new
    # default: render 'new' template
  end

  def create
    begin
      product_json = params[:product]
      product_json[:company_id] = session[:merchant_id].to_s
      @product = Product.create!(name: product_json[:name],
                                 description: product_json[:description],
                                 price: product_json[:price].to_f,
                                 stock_count: product_json[:stock_count].to_i,
                                 company_id: product_json[:company_id].to_i)
      flash[:notice] = "#{@product.name} was successfully created."
      redirect_to products_by_company_id_path
    rescue => err
      flash[:notice] = "Error creating: #{err}"
      redirect_to products_by_company_id_path
    end
  end

  def edit
    @product = Product.find params[:id]
  end

  def update
    begin
      @product = Product.find params[:id]
      @product.update_attributes!(product_params)
      flash[:notice] = "#{@product.name} was successfully updated."
      redirect_to product_path(@product)
    rescue => err
      flash[:notice] = "Error updating: #{err}"
      redirect_to products_by_company_id_path
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "Product '#{@product.name}' deleted."
    redirect_to products_by_company_id_path
  end

  def merchant_index
    @products = Product.where(company_id: session[:merchant_id]).all
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def product_params
    params.require(:product).permit(:name, :description, :price, :stock_count, :company_id)
  end
end
