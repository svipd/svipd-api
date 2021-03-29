class LoginController < ApplicationController

  def user_login
    @type = "user"
  end

  def user_login_post
    users = User.includes(:cart).where("LOWER (username) = ? and password = ?",
                              params[:username].downcase,
                              Digest::MD5.hexdigest(params[:password]))
    count = users.all.count
    if count > 0
      session[:user_logged_in] = true
      session[:user] = users.first
      session[:fname] = users.first.fname
      session[:cart] = users.first.cart
      redirect_to root_path
    else
      redirect_to user_login_path
      flash[:warning] = "Login failed. Please try again."
    end
  end

  def user_logout
    session[:user_logged_in] = nil
    session[:user] = nil
    session[:cart] = nil
    redirect_to root_path
  end

  def merchant_login
    @type = "merchant"
    if session[:merchant_id] != nil
      redirect_to products_by_company_id_path
    end
  end

  def merchant_login_post
    merchants = Company.where("LOWER (username) = ? and password = ?",  
                              params[:username].downcase, 
                              Digest::MD5.hexdigest(params[:password]))
    count = merchants.all.count
    if count > 0
      session[:merchant_id] =  merchants.first.company_id
      redirect_to products_by_company_id_path
    else
      redirect_to merchant_login_path
      flash[:warning] = "Login failed. Please try again. #{Digest::MD5.hexdigest(params[:password])} and #{Company.all.inspect}"
    end
  end

  def merchant_logout
    session[:merchant_id] = nil
    redirect_to merchant_login_path
  end
end