module ContractsHelper

  def make_links(contract)
    contract.link = SecureRandom.urlsafe_base64(5, false)
    contract.owner_link = SecureRandom.urlsafe_base64(5, false)
    return contract
  end

end
