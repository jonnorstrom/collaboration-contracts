require 'rails_helper'

RSpec.describe Contract, type: :model do

  describe "validations" do
    let(:contract) {create(:contract)}

    it{should have_many(:user_contracts)}
    it{should have_many(:users).through(:user_contracts)}
    it{should belong_to(:creator)}

    it "is valid with valid attributes" do
      expect(contract).to be_valid
    end
    it "is not valid without title" do
      contract.title = nil
      expect(contract).to_not be_valid
    end
    it "is not valid without owner_link" do
      contract.owner_link = nil
      expect(contract).to_not be_valid
    end
    it "is not valid without link" do
      contract.link = nil
      expect(contract).to_not be_valid
    end
    it "is not valid without viewer_link" do
      contract.viewer_link = nil
      expect(contract).to_not be_valid
    end
    it "should have user" do
      expect(contract.users).to be_truthy
    end
    it "it should have a creator" do
      expect(contract.creator).to be_truthy
    end
  end

  describe ".owner?" do
    let(:user_contract) {create(:user_contract)}
    let(:contract) {user_contract.contract}
    let(:user) {user_contract.user}

    it "should return false if user is not an owner" do
      expect(contract.owner?(create(:user))).to eq(false)
    end
    it "should return true if user is an owner" do
      expect(contract.owner?(user)).to eq(true)
    end
  end

  describe ".collaborator?" do
    let(:user_contract) {create(:user_contract_for_collaborator)}
    let(:contract) {user_contract.contract}
    let(:user) {user_contract.user}

    it "should return false if user is not a collaborator" do
      expect(contract.collaborator?(create(:user))).to eq(false)
    end
    it "should return true if user is a collaborator" do
      expect(contract.collaborator?(user)).to eq(true)
    end
  end

  describe ".viewer?" do
    let(:user_contract) {create(:user_contract_for_viewer)}
    let(:contract) {user_contract.contract}
    let(:user) {user_contract.user}

    it "should return false if user is not a viewer" do
      expect(contract.viewer?(create(:user))).to eq(false)
    end
    it "should return true if user is a viewer" do
      expect(contract.viewer?(user)).to eq(true)
    end
  end

  describe ".find_which_by" do
    let(:contract) {create(:contract)}

    it "should return nothing without correct link or id" do
      expect(Contract.find_which_by({id: 3, link: "0"})).to eq(nil)
    end
    it "should return nothing without correct link" do
      expect(Contract.find_which_by({id: contract.id, link: "0"})).to eq(nil)
    end
    it "should return nothing without correct id" do
      expect(Contract.find_which_by({id: contract.id+1, link: contract.link})).to eq(nil)
    end
    it "should return contract matching id and owner_link" do
      expect(Contract.find_which_by({id: contract.id, link: contract.owner_link})).to eq(contract)
    end
    it "should return contract matching id and link" do
      expect(Contract.find_which_by({id: contract.id, link: contract.link})).to eq(contract)
    end
  end

  describe ".set_user_contract" do
    let(:user_contract) {create(:user_contract)}
    let(:contract) {user_contract.contract}
    let(:user) {create(:user)}

    it "should set user to owner if link is owner_link" do
      contract.set_user_contract(contract.owner_link, user)
      expect(contract.owner?(user)).to eq(true)
    end
    it "should return UserContract if link is viewer_link" do
      contract.set_user_contract(contract.viewer_link, user)
      expect(UserContract.find_or_create_viewer(user, contract)).to eq(true)
    end
  end

  describe  ".user_list" do
    let(:user_contract) {create(:user_contract)}
    let(:contract) {user_contract.contract}
    let(:user) {user_contract.user}

    context "with single user on contract" do
      it "should return 'You' " do
        expect(contract.user_list(user)).to eq("You")
      end
    end
    context "with multiple users on contract" do
      before do
        contract.set_user_contract(contract.owner_link, create(:user))
      end
      it "should return multiple usernames in string" do
        expect(contract.user_list(user)).to eq("You, Joe S")
      end
    end
  end

  describe ".set_owner" do
    let(:user_contract) {create(:user_contract)}
    let(:contract) {user_contract.contract}
    let(:user) {create(:user)}

    it "should update user to owner" do
      expect(contract.owner?(user)).to eq(false)
      contract.set_owner(user)
      expect(contract.owner?(user)).to eq(true)
    end
  end

end
