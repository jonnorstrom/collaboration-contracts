require 'rails_helper'

RSpec.describe UserContract, type: :model do

  it{ should belong_to(:user) }
  it{ should belong_to(:contract) }

end
