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
      expect(uc.viewer). to eq(false)
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
end
