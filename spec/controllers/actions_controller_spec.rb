require 'rails_helper'

RSpec.describe API::ActionsController, type: :controller do
  describe 'GET #index' do
    before :each do
      @actions = [Action.create!, Action.create!, Action.create!]
    end
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it 'loads all actions into @actions' do
      # actions = [Action.create!, Action.create!, Action.create!]
      get :index
      expect(assigns(:actions)).to match_array(@actions)
    end
    it 'responds to requests for json' do
      request.env['HTTP_ACCEPT'] = 'application/json'
      get :index
      expect(response.body).to eq(@actions.to_json)
    end
    it 'responds to request for xml' do
      request.env['HTTP_ACCEPT'] = 'application/xml'
      get :index
      expect(response.body).to eq(@actions.to_xml)
    end
  end
end
