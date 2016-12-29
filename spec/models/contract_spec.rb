require 'rails_helper'

RSpec.describe Contract, type: :model do

  describe "validations" do
    before do
      @user_contract = create(:user_contract)
      @contract = @user_contract.contract
    end

    it{should have_many(:user_contracts)}
    it{should have_many(:users).through(:user_contracts)}

    it "is valid with valid attributes" do
      expect(@contract).to be_valid
    end
    it "is not valid without title" do
      @contract.title = nil
      expect(@contract).to_not be_valid
    end
    it "is not valid without owner_link" do
      @contract.owner_link = nil
      expect(@contract).to_not be_valid
    end
    it "is not valid without link" do
      @contract.link = nil
      expect(@contract).to_not be_valid
    end
    it "should have user" do
      expect(@contract.users).to be_truthy
    end
  end

  describe ".owner?" do
    before do
      @user_contract = create(:user_contract)
      @contract = @user_contract.contract
      @user = @user_contract.user
    end

    it "should return false if user is not an owner" do
      expect(@contract.owner?(create(:user))).to eq(false)
    end
    it "should return true if user is an owner" do
      expect(@contract.owner?(@user)).to eq(true)
    end
  end

  describe ".find_which_by" do
    before do
      @contract = create(:contract)
      @contract_id = @contract.id
    end

    it "should return nothing without correct link or id" do
      expect(Contract.find_which_by({id: 3, link: "0"})).to eq(nil)
    end
    it "should return nothing without correct link" do
      expect(Contract.find_which_by({id: @contract_id, link: "0"})).to eq(nil)
    end
    it "should return nothing without correct id" do
      expect(Contract.find_which_by({id: @contract_id+1, link: @contract.link})).to eq(nil)
    end
    it "should return contract matching id and owner_link" do
      expect(Contract.find_which_by({id: @contract_id, link: @contract.owner_link})).to eq(@contract)
    end
    it "should return contract matching id and link" do
      expect(Contract.find_which_by({id: @contract_id, link: @contract.link})).to eq(@contract)
    end
  end

  describe ".set_user_contract" do
    before do
      @user_contract = create(:user_contract)
      @contract = @user_contract.contract
      @user = create(:user)
    end

    it "should set user to owner if link is owner_link" do
      @contract.set_user_contract(@contract.owner_link, @user)
      expect(@contract.owner?(@user)).to eq(true)
    end
  end

end
