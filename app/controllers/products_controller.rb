class ProductsController < ApplicationController

  def show
    id = params[:id]
    @product = Product.find(id)
    @company = Company.find(@product.company_id)
  end

  def index
    @products = Product.all

    search = params[:search]
    if search != nil
      @products = Product.case_insensitive_search(@products, search["search"])
    end

    # Generate distances into @products and order
    if session[:location].nil?
      session[:location] = request.location.address
    end
    @products = Product.gen_dist_and_order(@products, session[:location], "dist-price", true) # sort by distance and price in ASC

    @product_list = []
    four_products = []
    counter = 0
    dist_lim = 100000000000000
    @products.each do |product|
      if product.distance > dist_lim
        next
      end
      counter = counter % 4
      four_products.push(product)
      if counter == 3
        @product_list.push(four_products)
        four_products = []
      end
      counter += 1
    end
    unless four_products.empty?
      @product_list.push(four_products)
    end
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
      @product.update(product_params)
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

  def merchant_products
    if session[:merchant_id] == nil
      redirect_to merchant_login_path
    end
    @go_back = false
    @products = Product.where(company_id: session[:merchant_id]).all
    search = params[:search]
    if search != nil
      @go_back = true
      @products = Product.case_insensitive_search(@products, search["search"])
    end
    if params[:sort] != nil
      if params[:sort] == "name"
        @products = Product.order_by_name(@products, params[:direction] == "asc" ? true : false)
      else
        @products = Product.order_by_price(@products, params[:direction] == "asc" ? true : false)
      end
    end
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def product_params
    params.require(:product).permit(:name, :description, :price, :stock_count, :company_id)
  end
end
