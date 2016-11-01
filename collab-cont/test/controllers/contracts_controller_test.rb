require 'test_helper'

class ContractsControllerTest < ActionDispatch::IntegrationTest
  test "Should not save contract without title" do
    contract = Contract.new
    assert_not contract.save, "Saved contract without title"
  end

  test "Should not save contract without link" do
    contract = Contract.new(title: "Contract Title")
    assert_not contract.save, "Saved contract without link #{contract.link}"
  end

  test "Should save with title and link" do
    contract = Contract.new(title: "Contract Title", link: "12345")
    assert contract.save, "Contract not saved with title and link"
  end

end
