class HomeController < ApplicationController
  def index
    @stories = Story.last(10).reverse
    @posts = Post.last(3).reverse
    @which = rand 2
  end
end
