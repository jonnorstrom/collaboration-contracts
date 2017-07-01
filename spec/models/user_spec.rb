require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    before do
      @user = build(:user)
    end

    it{ should have_many(:user_contracts) }
    it{ should have_many(:contracts).through(:user_contracts) }
    it{ should have_many(:created_contracts) }

  end

  describe ".users_name" do
    before do
      @user = create(:user)
    end
    it "returns a string" do
      expect(@user.users_name.class).to be(String)
    end
    it "returns the users first name + last initial" do
      expect(@user.users_name).to eq("Joe S.")
    end
  end

  describe ".created_contracts" do
    before do
      @contract = create(:contract)
      @user = @contract.creator
    end
    it "returns an collection of contracts" do
      expect(@user.created_contracts).to all(be_a_kind_of(Contract))
    end
  end

end
