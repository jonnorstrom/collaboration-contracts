require 'rails_helper'

RSpec.describe Answer, type: :model do
  contract = Contract.create(title: "Contract Title", link: "12345")
  decision = contract.decisions.create(description: "Decision description")

  subject {
    decision.answers.new(name: "Name", answer: "Answer")
  }

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
