require 'rails_helper'

RSpec.describe UserContract, type: :model do
  let(:uc) {create(:user_contract)}

  it{ should belong_to(:user) }
  it{ should belong_to(:contract) }

  describe "check attribues" do
    it "should have a owner attr: value true" do
      expect(uc.owner).to eq(true)
    end
    it "should have a viewer attr: value false" do
      expect(uc.viewer).to eq(false)
    end
  end

  describe  ".owner_contracts()" do
    it "should return array of owned contracts" do
      expect(UserContract.owner_contracts(uc.user).length).to eq(1)
    end
  end

  describe  ".users_contracts()" do
    before do
      uc.update(owner: false)
    end
    it "should return array of owned contracts" do
      expect(UserContract.users_contracts(uc.user).length).to eq(1)
    end
  end

  describe ".create_or_update()" do
    before do
      UserContract.create_or_update(uc.user, uc.contract, "Viewer")
      contract = UserContract.where(user_id: uc.user.id, contract_id: uc.contract.id).first
    end

    it "updates contract" do
      contract = UserContract.where(user_id: uc.user.id, contract_id: uc.contract.id).first
      expect(contract.owner).to be(false)
      expect(contract.viewer).to be(true)
    end

    it "creates contract" do
      expect { UserContract.create_or_update(create(:user), uc.contract, "Collaborator") }.to change {UserContract.count}.by(1)
    end

  end

end
