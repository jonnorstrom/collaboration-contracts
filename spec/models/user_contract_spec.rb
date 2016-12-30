require 'rails_helper'

RSpec.describe UserContract, type: :model do

  it{ should belong_to(:user) }
  it{ should belong_to(:contract) }

  describe  ".owner_contracts()" do
    before do
      @uc = create(:user_contract)
    end
    it "should return array of owned contracts" do
      expect(UserContract.owner_contracts(@uc.user).length).to eq(1)
    end
  end

  describe  ".users_contracts()" do
    before do
      @uc = create(:user_contract)
      @uc.update(owner: false)
    end
    it "should return array of owned contracts" do
      expect(UserContract.users_contracts(@uc.user).length).to eq(1)
    end
  end

end
