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

RSpec.describe PostsController, :type => :controller do
  FactoryBot.define do
    factory :post do
      title {""}
      message {""}
      user_id {1}
    end
  end
  let(:user) { FactoryBot.create(:user) }
  let(:cart) { FactoryBot.create(:cart) }
  let(:like) { FactoryBot.create(:like) }

  it "sad path: update post" do
    get(:update, {id: 1}, {'user_logged_in': false, "cart": {'id': 1, 'wishlist': "711719541080"}, "like": {'id': 5, 'likedlist': "711719541080"}})
    expect(response).to have_http_status(302)
    expect(flash[:warning]).to be_present
  end
  it "sad path 2: update post" do
    get(:update, {id: 1}, {'user_logged_in': true, "cart": {'id': 1, 'wishlist': "711719541080"}, "like": {'id': 5, 'likedlist': "711719541080"}})
    expect(response).to have_http_status(302)
    expect(flash[:notice]).to be_present
  end
  it "sad path 1: create post" do
    get(:create, {}, {'user_logged_in': true, "cart": {'id': 1, 'wishlist': "711719541080"}, "like": {'id': 5, 'likedlist': "711719541080"}})
    expect(response).to have_http_status(302)
    expect(flash[:notice]).to be_present
  end
  it "sad path 2: create post" do
    get(:create, {}, {'user_logged_in': false, "cart": {'id': 1, 'wishlist': "711719541080"}, "like": {'id': 5, 'likedlist': "711719541080"}})
    expect(response).to have_http_status(302)
    expect(flash[:warning]).to be_present
  end
  it "sad path 1: edit post" do
    get(:edit, {id: 1}, {'user_logged_in': false, "cart": {'id': 1, 'wishlist': "711719541080"}, "like": {'id': 5, 'likedlist': "711719541080"}})
    expect(response).to have_http_status(302)
    expect(flash[:warning]).to be_present
  end
  it "sad path 1: delete post" do
    get(:destroy, {id: 1}, {'user_logged_in': false, "cart": {'id': 1, 'wishlist': "711719541080"}, "like": {'id': 5, 'likedlist': "711719541080"}})
    expect(response).to have_http_status(302)
    expect(flash[:warning]).to be_present
  end
end
 