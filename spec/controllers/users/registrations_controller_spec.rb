require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "GET New User" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "Create User" do
    context "with correct new user data" do
      before do
        @user_count = User.all.count
        @user_params = FactoryGirl.attributes_for(:user)
        process :create, method: :post, :params => { user: @user_params }
      end
      it "should redirect upon save" do
        assert_response :redirect
      end
      it "should add user to database" do
        expect(User.all.count).to eq(@user_count + 1)
      end
      it "should permit and save first name" do
        expect(User.last.first_name).to eq("Joe")
      end
      it "should permit and save last name" do
        expect(User.last.last_name).to eq("Shmo")
      end
      it "should set current user (sign_in)" do
        expect(subject.current_user).to eq(User.last)
      end
    end
    context "with incorrect new user data" do
      before do
        process :create, method: :post, params: { user: {email: "", first_name: "", last_name: "", password: ""} }
      end
      it "should render new user template" do
        expect(response).to render_template("new")
      end
    end
  end


end # end rspec
