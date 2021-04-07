class PostsController < ApplicationController

  def show
  end

  def new
  end

  def edit
    if session[:user_logged_in]
      @post = Post.find params[:id]
    else
      flash[:warning] = "Page not available. Please login."
      redirect_to user_login_path
    end
  end
  
  def update
    if session[:user_logged_in]
      begin
        new_post = params[:post]
        @post = Post.find( params[:id].nil? ? params["id"] : params[:id] )
        if session[:user]["id"] != @post[:user_id]
          redirect_to root_path
        end
        @post.update( title: new_post[:title],
                      message: new_post[:message],
                      image: new_post[:image],
                      user_id: session[:user]["id"])
        flash[:notice] = "Your post was successfully updated."
        redirect_to user_profile_path
      rescue => err
        flash[:notice] = "Error updating: #{err}"
        redirect_to user_profile_path
      end
    else
      flash[:warning] = "Page not available. Please login."
      redirect_to user_login_path
    end
  end

  def create
    if session[:user_logged_in]
      begin
        new_post = params[:new_post]
        @post = Post.create!(title: new_post[:title],
                             message: new_post[:message],
                             image: new_post[:image],
                             user_id: session[:user]["id"])
        flash[:notice] = "#{@post.title} was successfully created."
        redirect_to user_profile_path
      rescue => err
        flash[:notice] = "Error creating post: #{err}"
        redirect_to user_profile_path
      end

    else
      flash[:warning] = "Page not available. Please login."
      redirect_to user_login_path
    end
  end

  def destroy
    if session[:user_logged_in]
      @post = Post.find(params[:id])
      if session[:user]["id"] != @post[:user_id]
        redirect_to root_path
      end
      @post.destroy
      flash[:notice] = "Deleted Post."
      redirect_to user_profile_path
    else
      flash[:warning] = "Page not available. Please login."
      redirect_to user_login_path
    end
  end
end
