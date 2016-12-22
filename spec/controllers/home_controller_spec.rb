require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET index" do
    before do
      get :index
    end
    it "has a 200 status code" do
      expect(response.status).to eq(200)
    end
    it "renders home/index" do
      expect(response).to render_template("home/index")
    end
  end
end
