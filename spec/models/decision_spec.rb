require 'rails_helper'

RSpec.describe Decision, type: :model do

  describe "validations" do
    before do
      @decision = build(:decision_with_answers)
    end

    it {should have_many(:answers).dependent(:destroy)}
    it {should belong_to(:contract)}

    it "is valid with valid attributes" do
      expect(@decision).to be_valid
    end
    it "is not valid without description" do
      @decision.description = nil
      expect(@decision).to_not be_valid
    end
    it "is not valid without contract_id" do
      @decision.contract_id = nil
      expect(@decision).to_not be_valid
    end
  end

  describe "user_answer_type?" do
    before do
      @decision = create(:decision)
      @answer = Answer.create(decision_id: @decision.id, answer: "Explain", name: "Joe Shmo")
    end
    
    it "returns true if decision has answer with answer.type and user.name" do
      expect(@decision.user_answer_type?(@answer.answer, @answer.name)).to be_truthy
    end
    it "returns false if user.name is wrong" do
      expect(@decision.user_answer_type?(@answer.answer, "BadBadNotGood")).to be_falsy
    end
    it "returns false if answer.type is wrong" do
      expect(@decision.user_answer_type?("BadBadNotgood", @answer.name)).to be_falsy
    end
  end

end
