class HomeController < ApplicationController
  
  def index
    @stories = Story.last(10).reverse
    @posts = Post.last(4).reverse
  end
end
