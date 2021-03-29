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





RSpec.describe CompaniesController, :type => :controller do
  FactoryBot.define do
    factory :company do
        name {"qty"}
        description {"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce vitae ipsum consectetur, semper dolor sed, dignissim enim."}
        password {"sjkdfjksdhfsd"}
        username {"askfjsdjkfksjd"}
      end
    end
    let(:company) { FactoryBot.create(:company) }

  it "renders the index template" do
    get :index
    expect(response).to render_template("index")
  end  
  it "returns a 200" do
    request.headers["Authorization"] = "foo"
    get :index
    expect(response).to have_http_status(:ok)
  end
  it "renders the index template with post/create" do
    post :index
    expect(response).to render_template("index")
  end 
  context "GET show/:id" do
    it "renders the show template" do
      get :show, id: 1
      expect(response).to render_template("show")
    end
  end
  context "GET edit/:id" do
    it "renders the edit template" do
      get :edit, id: 1
      expect(response).to render_template("edit")
    end
  end
  context "PATCH show/:id" do
    it "renders the update template with sad path" do
      get :update, id: 1
      expect(response).to redirect_to("/companies")
      expect(flash[:notice]).to be_present
    end
  end
  context "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end
end
 