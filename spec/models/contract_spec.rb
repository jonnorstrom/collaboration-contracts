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

end
