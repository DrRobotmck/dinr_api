require 'rails_helper'

RSpec.describe Api::ViolationsController, type: :controller do
  describe 'GET #index' do
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it 'loads all of the violations into @violations' do
      violations = [Violation.create!, Violation.create!]
      get :index
      expect(assigns(:violations)).to match_array(violations)
    end
    it 'responds with json' do
      request.env["HTTP_ACCEPT"] = 'application/json'
      violations = [Violation.create!, Violation.create!]
      get :index
      expect(response.body).to eq(violations.to_json)
    end
    it 'responds with xml' do
      request.env["HTTP_ACCEPT"] = 'application/xml'
      violations = [Violation.create!, Violation.create!]
      get :index
      expect(response.body).to eq(violations.to_xml)
    end
  end
  DatabaseCleaner.clean
end
