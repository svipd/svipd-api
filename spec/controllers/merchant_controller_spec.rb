require 'rails_helper'
if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end





RSpec.describe MerchantController, :type => :controller do


  context "GET stories/:merchant_id" do
    it "renders the story template" do
      get :stories, params: {:merchant_id => 1}
      expect(response).to render_template("stories")
    end
  end  
  # it "renders the merchant landing page" do
  # post :index
  # expect(response).to render_template("index")
  # end 
  
end
 