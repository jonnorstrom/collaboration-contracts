require 'rails_helper'

RSpec.describe Answer, type: :model do
  subject {
    FactoryGirl.create(:answer)
  }

  it {should belong_to(:decision)}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without answer" do
    subject.answer = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without decision_id" do
    subject.decision_id = nil
    expect(subject).to_not be_valid
  end

end
