require 'test_helper'

class DecisionsControllerTest < ActionDispatch::IntegrationTest

  test "Should not save decision without description" do
    decision = Decision.new(contract_id: 1)
    assert_not decision.save, "Saved decision without description"
  end

  test "Should not save decision without contract_id" do
    decision = Decision.new(description: "This is the description")
    assert_not decision.save, "Saved decision without contract_id"
  end

  # test "Should save decision with description & contract_id" do
  #   decision = Decision.new(description: "This is the description", contract_id: 1)
  #   assert decision.save, "Did not save decision with description and contract_id"
  # end

end
