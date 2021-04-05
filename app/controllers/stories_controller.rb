class StoriesController < ApplicationController

  $user_id_login_render = -1

  def show
    @hide_stories_in_title = true
    @story = Story.find(params[:id])
  end

  def new
    @hide_stories_in_title = true
  end

  def create
    @hide_stories_in_title = true
    begin
      story_json = params[:story]
      @story = Story.create!(title: story_json[:title],
                                 description: story_json[:description],
                                 image: story_json[:image],
                                 company_id: session[:merchant_id])
      User.send_email_to_users_new_story(story_json[:description], story_json[:title])
      flash[:notice] = "#{@story.title} was successfully created."
      redirect_to merchant_stories_path
    rescue => err
      flash[:notice] = "Error creating: #{err}"
      redirect_to merchant_stories_path
    end
  end

  def destroy
    @hide_stories_in_title = true
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to merchant_stories_path
  end
end
