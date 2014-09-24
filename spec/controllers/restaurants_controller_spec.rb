require 'rails_helper'

RSpec.describe API::RestaurantsController, type: :controller do
  describe 'GET #index' do
    before :each do
      boro = Boro.create!(name: 'Manhattan')
      @restaurants = [
        Restaurant.create!({dba: "Subway", current_grade: 'A', boro_id: boro.id}),
        Restaurant.create!({dba: "Subway", current_grade: 'B', boro_id: boro.id}),
        Restaurant.create!({dba: "India", current_grade: 'A', boro_id: boro.id})
        ]
    end
    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it 'loads all restaurants into @restaurants' do
      get :index
      expect(assigns(:restaurants)).to match_array(@restaurants)
    end
    it 'responds to requests for json' do
      request.env['HTTP_ACCEPT'] = 'application/json'
      get :index
      expect(response.body).to eq(@restaurants.to_json)
    end
    it 'reponds to requests for xml' do
      request.env['HTTP_ACCEPT'] = 'application/xml'
      get :index
      expect(response.body).to eq(@restaurants.to_xml)
    end
    it 'returns results based on params' do
      request.env['HTTP_ACCEPT'] = 'application/json'
      get :index, dba: 'Subway'
      expect(response.body).to eq([@restaurants[0], @restaurants[1]].to_json)
    end
    it 'returns results based on multiple params' do
      request.env['HTTP_ACCEPT'] = 'application/json'
      get :index, dba: 'Subway', current_grade: 'A'
      expect(response.body).to eq([@restaurants[0]].to_json)
    end
    it 'returns results based on boro params' do
      request.env['HTTP_ACCEPT'] = 'application/json'
      get :index, boro: 'Manhattan'
      expect(response.body).to eq(@restaurants.to_json)
    end
  end
  DatabaseCleaner.clean
end
