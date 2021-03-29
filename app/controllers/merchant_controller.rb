class MerchantController < ApplicationController

  def stories
    @hide_stories_in_title = true
    @stories = Story.where(company_id: session[:merchant_id]).all
    @company = Company.find(session[:merchant_id])
  end
end
