require 'rails_helper'

RSpec.describe User, type: :model do

  describe "validations" do
    before do
      @user = build(:user)
    end

    it{ should have_many(:user_contracts) }
    it{ should have_many(:contracts).through(:user_contracts) }

  end

  describe "users_name" do
    before do
      @user = create(:user)
    end
    it "should return a string" do
      expect(@user.users_name.class).to be(String)
    end
    it "should return the users first name + last initial" do
      expect(@user.users_name).to eq("Joe S.")
    end
  end

end
