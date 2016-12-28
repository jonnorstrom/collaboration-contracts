require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  # ++++++++++   Answer New  ++++++++++++
  describe "Get new" do
    before do
      @decision = create(:decision)
      get :new, params: {decision_id: @decision.id}
    end
    it "should assign answer variable" do
      expect(assigns(:answer)).to be_a_new(Answer)
    end
    it "should assign decision variable" do
      expect(assigns(:decision)).to eq(@decision)
    end
    it "should render new template" do
      expect(response).to render_template("new")
    end
  end

  # ++++++++++ Answer Create ++++++++++++
  describe "Create or Update" do
    context "answer create" do
      before do
        @decision = create(:decision)
        @user = create(:user)
        process :create, method: :post, :params => {answer: {answer: "Explain", user_id: @user.id, decision_id: @decision.id}}
      end
      it "should assign answer to new answer" do
        expect(assigns(:answer)).to eq(Answer.last)
      end
      it "should redirect when saved" do
        assert_response :redirect
      end
    end

    context "answer update" do
      before do
        @answer = create(:answer)
        @decision = @answer.decision
        @user = create(:user)
        process :create, method: :post, params: { answer: {user_id: @user.id, decision_id: @decision.id, answer: "consult"} }
      end
      it "should update answer type" do
        expect(assigns(:answer).answer).to eq("consult")
      end
      it "should redirect when saved" do
        assert_response :redirect
      end
    end
  end

end
