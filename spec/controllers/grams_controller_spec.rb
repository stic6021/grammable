require 'spec_helper'
require 'rails_helper'
require 'rspec/rails'
require 'devise'

class GramsControllerTest < ActionController::TestCase
  include Devise::Test::IntegrationHelpers

  def setup
  end
end

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, :type => :controller
end

RSpec.describe GramsController, type: :controller do
  describe "grams#show action" do
    it "should show the page if the gram is found" do
      sign_out(@current_user)
      gram = FactoryBot.create(:gram)
      get :show, params: { id: gram.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 if the gram is not found" do
      sign_out(@current_user)
      get :show, params: { id: 'TACOCAT' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "grams#index action" do
    login_user
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#new action" do
    it "should redirect to the sign in page if not logged in" do
      sign_out(@current_user)
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    login_user
    it "should successfully show a form to create a new gram" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#create action" do
    it "should redirect to the sign in page if not logged in" do
      sign_out(@current_user)
      post :create, params: { gram: { message: 'This gram was created without authentication.' } }
      expect(response).to redirect_to new_user_session_path
    end

    login_user
    it "should successfully create a new gram in the database" do
      initial_count = Gram.count
      msg = "Grams unit test; message #{rand(100)}"
      post :create, params: { gram: { message: msg } }
      expect(response).to redirect_to(root_path)
      gram = Gram.last
      expect(gram.message).to eq(msg)
      expect(gram.user).to eq @current_user
      expect(Gram.count).to eq (initial_count + 1)
    end

    it "should correctly detect and handle validation errors" do
      initial_count = Gram.count
      post :create, params: { gram: { message: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Gram.count).to eq initial_count
    end
  end
end
