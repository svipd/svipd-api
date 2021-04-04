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
      client = Aws::SNS::Client.new(region: 'us-east-1',
                                      access_key_id: 'AKIAQ2KQVMG47K7DN476',
                                      secret_access_key: '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')
      sns = Aws::SNS::Resource.new(client: client)
      topic = sns.topic('arn:aws:sns:us-east-1:056540619193:svipd-stories')
      topic.publish({message: story_json[:description],
                     subject: story_json[:title]})
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
