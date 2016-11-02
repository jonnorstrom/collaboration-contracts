require 'rails_helper'

RSpec.describe Decision, type: :model do
  contract = Contract.create(title: "Contract Title", link: "12345")
  subject {
    contract.decisions.new(description: "Decision description")
  }

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
