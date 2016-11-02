module ContractsHelper

  def make_link
    SecureRandom.urlsafe_base64(5, false)
  end
  
end
