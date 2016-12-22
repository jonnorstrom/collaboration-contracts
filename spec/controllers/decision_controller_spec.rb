require 'rails_helper'

RSpec.describe DecisionsController, type: :controller do
  # +++++++++++++    Decision New   ++++++++++++++
  describe "Get new" do
    before do
      @contract = create(:contract)
      get :new, params: {contract_id: @contract.id}
    end
    it "should assign decision variable" do
      expect(assigns(:decision)).to be_a_new(Decision)
    end
    it "should assign contract_id variable" do
      expect(assigns(:contract_id)).to eq("#{@contract.id}")
    end
    it "should render new template" do
      expect(response).to render_template("new")
    end
  end

  # +++++++++++++  Decision Create  ++++++++++++++
  describe "Create" do
    before do
      @contract = create(:contract)
      process :create, method: :post, params: { decision: {description: "Description", contract_id: @contract.id} }
    end
    it "should assign decision variable" do
      expect(assigns(:decision)).to be_a(Decision)
    end
    it "should assign contract variable" do
      expect(assigns(:contract)).to be_a(Contract)
    end
    it "should assign contract variable as decisions contract" do
      expect(assigns(:contract)).to eq(@contract)
    end

    context "with errors" do
      before do
        process :create, method: :post, params: { decision: {description: "", contract_id: @contract.id} }
      end
      it "should assign decision_error_messages variable" do
        expect(assigns(:decision_error_messages)).to eq(["Description can't be blank"])
      end
      it "should render contracts/show page" do
        expect(response).to render_template("contracts/show")
      end
    end

    context "without errors" do
      it "should respond with redirect" do
        assert_response :redirect
      end
    end

  end

  # +++++++++++++  Decision Update  ++++++++++++++
  describe "Update" do
    before do
      @decision = create(:decision)
      process :update, method: :post, params: { decision: {description: "Updated Title", id: @decision.id} }
    end
    it "should assign decision variable to a decision" do
      expect(assigns(:decision)).to eq(@decision)
    end
    it "should assign contract variable to decisions contract" do
      expect(assigns(:contract)).to eq(@decision.contract)
    end
    it "should update decision description" do
      expect(assigns(:decision).description).to eq("Updated Title")
    end
    it "should redirect upon saving" do
      assert_response :redirect
    end
  end

  # +++++++++++++ Decision Destroy  ++++++++++++++
  describe "Destroy" do
    before do
      @decision = create(:decision)
      process :destroy, method: :post, params: {decision_id: @decision.id}
    end
    it "should assign decision variable to decision" do
      expect(assigns(:decision)).to eq(@decision)
    end
    it "should assign contract to decisions contract" do
      expect(assigns(:contract)).to eq(@decision.contract)
    end
    it "should destroy decision" do
      @decision = create(:decision)
      expect {process :destroy, method: :post, params: {decision_id: @decision.id}}.to change(Decision, :count).by(-1)
    end
    it "should redirect after destroy" do
      assert_response :redirect
    end
  end
end
