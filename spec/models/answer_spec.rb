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

  describe "find_all_names(type, answers, user)" do
    before do
      @answer = create(:answer)
      @type = @answer.answer
      @user = {name: "Joe Shmo", id: @answer.contract.user_id}
    end
      it "should return an array" do
        expect(Answer.find_all_names(@type, Answer.all, @user)).to eq(@user[:name])
      end
  end

  describe ".types" do
    it "should return an array of all answer options" do
      expect(Answer.types).to  eq(['Explain', 'Consult', 'Agree', 'Advise', 'Inquire'])
    end
  end

  describe ".contract" do
    before do
      @answer = build(:answer)
    end
    it "should return the contract attached to answers decision" do
      expect(@answer.contract).to eq(Contract.find(@answer.decision.contract_id))
    end
  end

  describe ".viewable?(user)" do
    before do
      @answer = create(:answer)
      @bad_user = {name: "Bad", id: 999}
      @user = {name: "Joe Shmo", id: @answer.contract.user_id}
    end
    it "should return true if contract reviewable" do
      @answer.contract.update(reviewable: true)
      expect(@answer.viewable?(@bad_user)).to be_truthy
    end
    it "should return true if it is user's answer" do
      @user[:id] = 0
      expect(@answer.viewable?(@user)).to be_truthy
    end
    it "should return true if user is contract owner" do
      @user[:name] = "whoever"
      expect(@answer.viewable?(@user)).to be_truthy
    end
    it "should return false if user is not contract owner, answer owner & contract is not reviewable" do
      expect(@answer.viewable?(@bad_user)).to be_falsy
    end
  end

  describe "user_answer?(user)" do
      before do
        @answer = create(:answer)
        @user = {name: "Joe Shmo", id: @answer.contract.user_id}
      end
      it "should return true if answer.name == username" do
        expect(@answer.user_answer?(@user)).to be true
      end
      it "should return false if answer.name != username" do
        @user[:name] = "whoever"
        expect(@answer.user_answer?(@user)).to be false
      end
  end

  describe "contract_owner?(user)" do
      before do
        @answer = create(:answer)
        @user = {name: "Joe Shmo", id: @answer.contract.user_id}
      end
      it "should return true if user.id == contract.user_id" do
        expect(@answer.contract_owner?(@user)).to be true
      end
      it "should return false if user.id != contract.user_id" do
        @user[:id] = 0
        expect(@answer.contract_owner?(@user)).to be false
      end
  end

end
