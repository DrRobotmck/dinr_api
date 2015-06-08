require 'rails_helper'

RSpec.describe Api::ActionsController, type: :controller do
  describe 'GET #index' do
    before :each do
      @actions = [Action.create!, Action.create!, Action.create!]
      request.env['HTTP_ACCEPT'] = 'application/json'
    end
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it 'loads all actions into @actions' do
      get :index
      expect(assigns(:actions)).to match_array(@actions)
    end
    context 'a request is made for json data' do
      it 'responds to requests for json' do
        get :index
        expect(response.body).to eq(@actions.to_json)
      end
    end

    context 'a request is made for xml data' do
      before { request.env['HTTP_ACCEPT'] = 'application/xml' }
      it 'responds to request for xml' do
        get :index
        expect(response.body).to eq(@actions.to_xml)
      end
    end
  end
  DatabaseCleaner.clean
end
