require 'rails_helper'

RSpec.describe ContractsController, type: :controller do
  # ++++++++++ Contract New ++++++++++++
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

  # ++++++++++ Contract Create ++++++++++++
  describe "Create" do
    context "with user signed in" do
      before do
        session[:user_id] = 1
        process :create, method: :post, params: {contract: {title: "Contract Title", theme: "Contract Theme"} }
      end
      it "should assign contract variable" do
        expect(assigns(:contract)).to be_a(Contract)
      end
      it "should set contract user when logged in" do
        expect(assigns(:contract).user_id).to eq(1)
      end
      it "should not create a new user" do
        expect(assigns(:user)).to be(nil)
      end
    end

    context "without user signed in" do
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

    context "with||without user signed in" do
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

# ++++++++++ Contract Update ++++++++++++
  describe "Update" do
    before do
      @contract = create(:contract)
    end

    it "assigns contract" do
      process :update, method: :post, params: {id: @contract.id, link: @contract.owner_link}
      expect(assigns(:contract)).to eq(@contract)
    end

    context "reviewable" do
      before do
        process :update, method: :post, params: {task:"review", id: @contract.id, link: @contract.owner_link}
      end
      it "should toggle contract reviewable boolean" do
        expect(assigns(:contract).reviewable).to eq(true)
      end
      it "should not toggle contract complete boolean" do
        expect(assigns(:contract).complete).to eq(false)
      end
      it "should redirect page upon save" do
        assert_response :redirect
      end
    end

    context "complete status" do
      before do
          process :update, method: :post, params: {task:"complete", id: @contract.id, link: @contract.owner_link}
      end
      it "should toggle contract complete boolean" do
        expect(assigns(:contract).complete).to eq(true)
      end
      it "should not toggle contract reviewable boolean" do
        expect(assigns(:contract).reviewable).to eq(false)
      end
      it "should redirect page upon save" do
        assert_response :redirect
      end
    end
  end

  describe "GET Show" do
    before do
      @contract = create(:contract)
      process :show, method: :get, params: {id: @contract.id, link: @contract.owner_link}
    end
    it "should assign contract variable" do
      expect(assigns(:contract)).to eq(@contract)
    end
    it "should assign user variable" do
      expect(assigns(:user)).to be_truthy
    end
    it "should assign owner variable" do
      expect(assigns(:owner)).to be_in([true, false])
    end
    it "should render show page" do
      expect(response).to render_template("show")
    end

    context "with owner link" do
      it "should assign owner variable to true" do
        expect(assigns(:owner)).to be(true)
      end
    end

    context "with regular link" do
      before do
        @contract = create(:contract)
        process :show, method: :get, params: {id: @contract.id, link: @contract.link}
      end
      it "should assign owner variable to false" do
        expect(assigns(:owner)).to be(false)
      end
    end
  end


end
