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





RSpec.describe StoriesController, :type => :controller do
  FactoryGirl.define do
    factory :story do
        title "qty"
        description "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce vitae ipsum consectetur, semper dolor sed, dignissim enim."
        image "x"
        company_id 1
      end
    end
    let(:story) { FactoryGirl.create(:story) }
  context "GET show/:id" do
    it "renders the product show template" do
      get :show, id: 4
      expect(response).to render_template("show")
    end
  end
  context "GET new" do
    it "renders the product new template" do
      get :new
      expect(response).to render_template("new")
    end
  end
  context "POST create" do
    it "renders the product new template with create" do
      post :create
      expect(response).to redirect_to("/merchant/stories")
    end
  end
  describe "DELETE#destroy" do

    it "Delete requested story" do
      delete :destroy, {:id => story.id}
      expect(response).to have_http_status(302)
    end
  end
end
 