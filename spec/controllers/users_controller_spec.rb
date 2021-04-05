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





RSpec.describe UsersController, :type => :controller do
  FactoryBot.define do
    factory :user do
      fname {"fname"}
      lname {"lname"}
      password {"x"}
      username {"user1"}
    end
    factory :cart do
      wishlist {""}
      product {""}
      user_id {1}
    end
    factory :like do
      likedlist {""}
      user_id {1}
    end
  end
  let(:user) { FactoryBot.create(:user) }
  let(:cart) { FactoryBot.create(:cart) }
  let(:like) { FactoryBot.create(:like) }

  it "Adding to wishlist" do
    post(:add_to_wishlist, {'product' => "194721725820"}, {'user_logged_in': true, "cart": {'id': 1, 'wishlist': "711719541080"}})
    expect(response).to have_http_status(:no_content)
  end
  it "Adding to likedlist" do
    post(:add_to_likedlist, {'product' => "194721725820"}, {'user_logged_in': true, "like": {'id': 5, 'likedlist': "711719541080"}})
    expect(response).to have_http_status(:no_content)
  end
  it "Removing from wishlist" do
    post(:delete_from_wishlist, {'barcode' => "194721725820"}, {'user_logged_in': true, "cart": {'id': 1, 'wishlist': "711719541080"}})
    expect(response).to redirect_to("/users/wishlist")
  end
  it "Removing from likedlist" do
    post(:delete_from_likedlist, {'barcode' => "194721725820"}, {'user_logged_in': true, "like": {'id': 5, 'likedlist': "711719541080"}})
    expect(response).to redirect_to(user_profile_path)
  end
  it "rendering profile page" do
    get(:profile, {}, {'user_logged_in': true, "user": {"id": 1}, "cart": {'id': 1, 'wishlist': "711719541080"}, "like": {'id': 5, 'likedlist': "711719541080"}})
    expect(response).to have_http_status(200)
  end
  it "rendering wishlist page" do
    get(:wishlist, {}, {'user_logged_in': true, "cart": {'id': 1, 'wishlist': "711719541080"}, "like": {'id': 5, 'likedlist': "711719541080"}})
    expect(response).to have_http_status(200)
  end
end
 