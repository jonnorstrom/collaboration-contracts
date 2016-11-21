require 'rails_helper'

RSpec.describe Contract, type: :model do
  subject{
    FactoryGirl.create(:filled_contract, decisions_count: 4)
  }
  it{should have_many(:decisions)}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without owner_link" do
    subject.owner_link = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without link" do
    subject.link = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without user_id" do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  describe ".owner?" do
    let(:user_id) {subject.user_id}
    it "returns false if user_id does not match" do
      expect(subject.owner?(user_id - 1)).to eq(false)
    end
    it "returns ture if user_id matches" do
      expect(subject.owner?(user_id)).to eq(true)
    end
  end

  describe ".find_which_by" do
    let(:id) {subject.id}
    it "returns nothing without correct link or id" do
      expect(Contract.find_which_by({id: 3, link: "0"})).to eq(nil)
    end
    it "returns nothing without correct link" do
      expect(Contract.find_which_by({id: id, link: "0"})).to eq(nil)
    end
    it "returns nothing without correct id" do
      expect(Contract.find_which_by({id: id+1, link: "12345"})).to eq(nil)
    end
    it "returns contract matching id and owner_link" do
      expect(Contract.find_which_by({id: id, link: "abcde"})).to eq(subject)
    end
    it "returns contract matching id and link" do
      expect(Contract.find_which_by({id: id, link: "12345"})).to eq(subject)
    end
  end

  describe ".find_or_set_owner" do
    let(:link) {"abcde"}
    let(:user_id) {subject.user_id}
    it "returns true if link is owner_link" do
      expect(subject.find_or_set_owner(link,user_id + 1)).to eq(true)
    end
    it "returns true if user_id is owners id" do
      expect(subject.find_or_set_owner("",user_id)).to eq(true)
    end
    it "returns false if user_id and link don't match" do
      expect(subject.find_or_set_owner("",user_id + 1)).to eq(false)
    end
  end


end
