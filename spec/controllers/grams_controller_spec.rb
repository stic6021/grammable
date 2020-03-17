require 'spec_helper'
require 'rails_helper'
require 'rspec/rails'
require 'devise'

class GramsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in FactoryBot.create(:user)
  end
end

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, :type => :controller
end

RSpec.describe GramsController, type: :controller do
  describe "grams#index action" do
    login_user
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#new action" do
    login_user
    it "should successfully show a form to create a new gram" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "grams#create action" do
    login_user
    it "should successfully create a new gram in the database" do
      msg = FactoryBot.create(:gram).message
      post :create, params: { gram: { message: msg } }
      expect(response).to redirect_to(root_path)
      expect(Gram.last.message).to eq(msg)
    end

    it "should correctly detect and handle validation errors" do
      initial_count = Gram.count
      post :create, params: { gram: { message: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Gram.count).to eq initial_count
    end
  end
end
