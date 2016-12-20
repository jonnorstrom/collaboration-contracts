require 'rails_helper'

RSpec.describe Contract, type: :model do

  describe "validations" do
    before do
      @contract = build(:contract)
    end

    it{should belong_to(:user)}
    it{should have_many(:decisions)}

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
    it "is not valid without user_id" do
      @contract.user_id = nil
      expect(@contract).to_not be_valid
    end
  end

  describe ".owner?" do
    before do
      @contract = build(:contract)
      @user_id = @contract.user_id
    end

    it "returns false if user_id does not match" do
      expect(@contract.owner?(@user_id - 1)).to eq(false)
    end
    it "returns true if user_id matches" do
      expect(@contract.owner?(@user_id)).to eq(true)
    end
  end

  describe ".find_which_by" do
    before do
      @contract = create(:contract)
      @contract_id = @contract.id
    end

    it "returns nothing without correct link or id" do
      expect(Contract.find_which_by({id: 3, link: "0"})).to eq(nil)
    end
    it "returns nothing without correct link" do
      expect(Contract.find_which_by({id: @contract_id, link: "0"})).to eq(nil)
    end
    it "returns nothing without correct id" do
      expect(Contract.find_which_by({id: @contract_id+1, link: @contract.link})).to eq(nil)
    end
    it "returns contract matching id and owner_link" do
      expect(Contract.find_which_by({id: @contract_id, link: @contract.owner_link})).to eq(@contract)
    end
    it "returns contract matching id and link" do
      expect(Contract.find_which_by({id: @contract_id, link: @contract.link})).to eq(@contract)
    end
  end

  describe ".find_or_set_owner" do
    before do
      @contract = build(:contract)
      @owner_link = @contract.owner_link
      @link = @contract.link
      @user_id = @contract.user_id
    end

    it "returns true if link is owner_link" do
      expect(@contract.find_or_set_owner(@owner_link, @user_id + 1)).to eq(true)
    end
    it "returns true if user_id is owners id" do
      expect(@contract.find_or_set_owner(@link, @user_id)).to eq(true)
    end
    it "returns false if user_id and link don't match" do
      expect(@contract.find_or_set_owner(@link, @user_id + 1)).to eq(false)
    end
  end

end
