require 'rails_helper'

RSpec.describe ContractsController, type: :controller do

  describe "GET new" do
    it "assigns @contract" do
      get :new
      expect(assigns(:contract)).to be_a_new(Contract)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "Create" do

    context "with user" do
      before do
        session[:user_id] = 1
        process :create, method: :post, params: {contract: {title: "Contract Title", theme: "Contract Theme"} }
      end
      it "assigns @contract" do
        expect(assigns(:contract)).to be_a(Contract)
      end
      it "should set contract user when logged in" do
        expect(assigns(:contract).user_id).to eq(1)
      end
      it "should not create a new user" do
        expect(assigns(:user)).to be(nil)
      end
    end

    context "without user" do
      before do
        process :create, method: :post, params: {contract: {title: "Contract Title", theme: "Contract Theme"} }
      end
      it "should create user when not signed in" do
        expect(assigns(:user)).to be_a(User)
      end
      it "should store user_id in session" do
        expect(session[:user_id]).to be_truthy
      end
    end

    context "with||without user" do
      it "should redirect to contracts page when saved" do
        process :create, method: :post, params: {contract: {title: "Contract Title", theme: "Contract Theme"} }
        assert_response :redirect
      end
      before do
        process :create, method: :post, params: {contract: {title: "", theme: "Contract Theme"} }
      end
      it "should render home/index when contract cannot save" do
        expect(response).to render_template("home/index")
      end
      it "should assign error_messages" do
        expect(assigns(:error_messages)).to eq(["Title can't be blank"])
      end
    end
  end

end
