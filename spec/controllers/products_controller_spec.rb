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





RSpec.describe ProductsController, :type => :controller do

  FactoryGirl.define do
    factory :product do
        name "qty"
        description "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce vitae ipsum consectetur, semper dolor sed, dignissim enim."
        price 5
        stock_count 50
        company_id 1
      end
    end
    let(:product) { FactoryGirl.create(:product) }

  it "renders the product index template" do
    get :index
    expect(response).to render_template("index")
  end  
  it "renders the product index template with search" do
    get :index, {:search => "t"}
    expect(response).to render_template("index")
  end  
  it "returns a 200" do
    request.headers["Authorization"] = "foo"
    get :index
    expect(response).to have_http_status(:ok)
  end
  it "renders the product index template with post/create" do
    post :index
    expect(response).to render_template("index")
  end 
  context "GET show/:id" do
    it "renders the product show template" do
      get :show, id: 1
      expect(response).to render_template("show")
    end
  end
  context "GET edit/:id" do
    it "renders the product edit template" do
      get :edit, id: 1
      expect(response).to render_template("edit")
    end
  end
  context "PATCH show/:id" do
    it "renders the product update template with sad path" do
      get :update, id: 1
      expect(response).to redirect_to("/products/merchant-index")
      expect(flash[:notice]).to be_present
    end
  end
  # the following does not work right now
  context "PATCH show/:id" do
    it "renders the product update template with sad path" do
      get :update, {:id => 1, :product_params => product}
      expect(response).to redirect_to("/products/merchant-index")
      expect(flash[:notice]).to be_present
    end
  end
  context "GET new" do
    it "renders the product new template" do
      get :new
      expect(response).to render_template("new")
    end
  end
  context "POST create" do
    it "renders the product new template with create (sad path)" do
      post :create
      expect(response).to redirect_to("/products/merchant-index")
      expect(flash[:notice]).to be_present
    end
  end
  context "POST create" do
    it "renders the product new template with create and with a product" do
      product.id = nil
      post :create, {:product => product}, merchant_id: 1
      expect(response).to redirect_to("/products/merchant-index")
      expect(flash[:notice]).to be_present
    end
  end
  # TODO: Need to get it to actually delete
  describe "DELETE#destroy" do

    it "Delete requeted product" do
      delete :destroy, {:id => product.id}
      expect(response).to have_http_status(302)
    end
  end
end
 