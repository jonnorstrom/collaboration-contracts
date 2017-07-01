module ContractsHelper

  def add_links(contract)
    p "+++++++++ Whoah add_links is working.. ++++++++++++"
    contract.link = SecureRandom.urlsafe_base64(5, false)
    contract.owner_link = SecureRandom.urlsafe_base64(5, false)
    contract.viewer_link = SecureRandom.urlsafe_base64(5, false)
    return contract
  end

end
