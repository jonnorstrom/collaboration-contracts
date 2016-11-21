require 'rails_helper'

RSpec.describe Decision, type: :model do
  subject {
    FactoryGirl.create(:decision_with_answers)
  }

  it {should have_many(:answers)}
  it {should belong_to(:contract)}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without contract_id" do
    subject.contract_id = nil
    expect(subject).to_not be_valid
  end

end
