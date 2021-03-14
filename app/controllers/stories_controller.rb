class StoriesController < ApplicationController

  $user_id_login_render = -1;

  def show
    @story = Story.find(params[:id])
  end

  def new
  end

  def create
    begin
      story_json = params[:story]
      @story = Story.create!(title: story_json[:title],
                                 description: story_json[:description],
                                 image: story_json[:image],
                                 company_id: session[:merchant_id])
      flash[:notice] = "#{@story.title} was successfully created."
      redirect_to merchant_stories_path
    rescue => err
      flash[:notice] = "Error creating: #{err}"
      redirect_to merchant_stories_path
    end
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to merchant_stories_path
  end


  def stories_paths

    @stor = Story.find(params[:id])
    puts "WE ARE HERE NOW"
    puts @stor.title

  end



end
