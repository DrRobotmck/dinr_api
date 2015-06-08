require 'rails_helper'

RSpec.describe Api::ViolationsController, type: :controller do
  describe 'GET #index' do
    violations = []
    before do
      violations = [Violation.create!, Violation.create!]
      request.env["HTTP_ACCEPT"] = 'application/json'
    end
    
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    
    it 'loads all of the violations into @violations' do
      get :index
      expect(assigns(:violations)).to match_array(violations)
    end

    context 'a request is made for json data' do      
      it 'responds with json' do
        get :index
        expect(response.body).to eq(violations.to_json)
      end
    end

    context 'a request is made for xml' do
      before { request.env["HTTP_ACCEPT"] = 'application/xml' }      
      it 'responds with xml' do
        get :index
        expect(response.body).to eq(violations.to_xml)
      end
    end
  end
  DatabaseCleaner.clean
end
