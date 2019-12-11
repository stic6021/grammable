require 'rails_helper'

RSpec.describe GramsController, type: :controller do
  describe "grams#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#new action" do
    it "should successfully show a form to create a new gram" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#create action" do
    it "should successfully create a new gram in the database" do
      msg = "This is a fountain."
      post :create, params: { gram: { message: msg } }
      expect(response).to redirect_to(root_path)
      expect(Gram.last.message).to eq(msg)
    end
  end
end
