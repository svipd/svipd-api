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





RSpec.describe LoginController, :type => :controller do


  it "renders the login template" do
    get :merchant_login
    expect(response).to render_template("login/merchant_login")
  end  
  it "renders the logged in template sad path" do
    post :merchant_login_post, :username => "Walmart", :password => "xxxxxxx"
    expect(response).to redirect_to("/merchant/login")
  end 
  it "renders the logged in template" do
    post :merchant_login_post, :username => "Walmart", :password => "x"
    expect(response).to redirect_to("/products/merchant-products")
  end 
  
end
 