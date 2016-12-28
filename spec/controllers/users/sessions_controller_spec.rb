require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "GET New Session" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "Create Session" do
    context "with correct user data" do
      before do
        @user_params = FactoryGirl.attributes_for(:user)
        @user = User.create(@user_params)
        process :create, method: :post, :params => { user: @user_params }
      end
      it "should redirect" do
        assert_response :redirect
      end
      it "should set current user" do
        expect(subject.current_user).to eq(@user)
      end
    end
    context "with incorrect user data" do
      before do
        @user_params = FactoryGirl.attributes_for(:user)
        process :create, method: :post, :params => { user: @user_params }
      end
      it "should re-render new template" do
        expect(response).to render_template("new")
      end
      it "should flash errors" do
        expect(flash[:alert]).to eq("Invalid Email or password.")
      end
    end
  end

  describe "Destroy Session" do
    context "with user already signed in" do
      before do
        sign_in create(:user)
      end
      it "should remove current user" do
        process :destroy, method: :post
        expect(subject.current_user).to eq(nil)
      end
      it "should redirect to root" do
        process :destroy, method: :post
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
