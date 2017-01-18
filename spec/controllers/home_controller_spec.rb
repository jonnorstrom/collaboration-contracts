require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET index" do
    before do
      @user = create(:user)
      sign_in @user
      get :index
    end
    it "should redirect" do
      assert_response :redirect
    end
  end
end
