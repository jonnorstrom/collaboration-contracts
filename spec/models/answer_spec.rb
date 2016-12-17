require 'rails_helper'

RSpec.describe Answer, type: :model do

  describe "validations" do

    before do
     @answer = build(:answer)
    end

    it {should belong_to(:decision)}

    it "is valid with valid attributes" do
      expect(@answer).to be_valid
    end

    it "is not valid without name" do
      @answer.name = nil
      expect(@answer).to_not be_valid
    end
    it "is not valid without answer" do
      @answer.answer = nil
      expect(@answer).to_not be_valid
    end

    it "is not valid without decision_id" do
      @answer.decision_id = nil
      expect(@answer).to_not be_valid
    end
  end

  describe ".types" do
    it "should return an array of all answer options" do
      expect(Answer.types).to  eq(['Explain', 'Consult', 'Agree', 'Advise', 'Inquire'])
    end
  end

  describe ".contract" do
    before do
      @answer = FactoryGirl.build(:answer)
    end
    it "should return the contract attached to answers decision" do
      expect(@answer.contract).to eq(Contract.find(@answer.decision.contract_id))
    end
  end

end
