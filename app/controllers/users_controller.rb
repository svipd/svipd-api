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
    if user_params[:password].length > 7
      begin
        new_params = user_params
        new_params[:password] = Digest::MD5.hexdigest(new_params[:password])
        @user = User.create!(new_params)
        Cart.create!({:user_id => @user.id})
        Like.create!({:user_id => @user.id})
        flash[:success] = "#{@user.username} was successfully created. Please login below."
        redirect_to user_login_path
      rescue => err
        flash[:warning] = "#{err}"
        if flash[:warning].include? "username"
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

  def add_to_likedlist
    head :no_content
    if session[:user_logged_in]
      liked = session[:like]
      likedlist = nil
      if liked != nil
        likedlist = liked["likedlist"]
      else
        liked = Like.create!({:user_id => session[:user]["id"]})
      end
      if likedlist == nil
        likedlist = []
      else
        likedlist = likedlist.split(',')
      end
      product = params[:product]
      unless likedlist.include?(product)
        likedlist.push(product)
      else
        likedlist.delete(product)
      end
      @like = Like.find(liked["id"].to_i)
      likedlist_str = likedlist.join(",")
      @like.update({:likedlist => likedlist_str})
      liked["likedlist"] = likedlist_str
      session[:like] = liked
    end
  end

  def add_to_wishlist
    head :no_content
    if session[:user_logged_in]
      cart = session[:cart]
      wishlist = cart["wishlist"]
      if wishlist == nil
        wishlist = []
      else
        wishlist = wishlist.split(',')
      end
      product = params[:product]
      unless wishlist.include?(product)
        wishlist.push(product)
      end
      @cart = Cart.find(cart["id"].to_i)
      wishlist_str = wishlist.join(",")
      @cart.update({:wishlist => wishlist_str})
      cart["wishlist"] = wishlist_str
      session[:cart] = cart
    end
  end

  def wishlist
    if session[:user_logged_in]
      cart = session[:cart]
      wishlist = cart["wishlist"]
      if wishlist == nil
        wishlist = []
      else
        wishlist = wishlist.split(',')
      end
      @products = []
      wishlist.each do |product|
        product = Product.find_by("barcode": product)
        @products.push(product)
      end
    else
      redirect_to root_path
    end
  end

  def delete_from_wishlist
    barcode = params[:barcode]
    cart = session[:cart]
    wishlist = cart["wishlist"]
    wishlist = wishlist.split(',')
    wishlist.delete(barcode)
    wishlist_str = wishlist.join(",")
    @cart = Cart.find(cart["id"].to_i)
    @cart.update({:wishlist => wishlist_str})
    cart["wishlist"] = wishlist_str
    session[:cart] = cart
    redirect_to user_wishlist_path
  end

  def applicable_stores
    cart = session[:cart]
    wishlist = cart["wishlist"]
    wishlist = wishlist.split(',')
    distance = params[:distance][:distance].to_f
    @companies = User.get_applicable_stores(wishlist, distance, session[:location])
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def user_params
    params.require(:user).permit(:username, :fname, :lname, :password)
  end
end
