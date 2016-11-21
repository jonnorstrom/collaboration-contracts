require 'rails_helper'

RSpec.describe ContractsController, type: :controller do

  describe "GET new" do
    it "assigns @contract" do
      get :new
      expect(assigns(:contract)).to be_a_new(Contract)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

end
