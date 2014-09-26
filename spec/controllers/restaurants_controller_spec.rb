require 'rails_helper'

RSpec.describe Api::RestaurantsController, type: :controller do
  describe 'GET #index' do
    before :each do
      boro = Boro.create!(name: 'Manhattan')
      cuisine = Cuisine.create!(description: 'Filipino')
      @restaurants = [
        Restaurant.create!({
          dba: "Subway",
          current_grade: 'A',
          boro_id: boro.id,
          cuisine_id: cuisine.id
          }),
        Restaurant.create!({
          dba: "Subway",
          current_grade: 'B',
          boro_id: boro.id
          }),
        Restaurant.create!({
          dba: "India",
          current_grade: 'A',
          boro_id: boro.id
          })
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
      get :index, dba: 'Subway', current_grade: 'a'
      expect(response.body).to eq([@restaurants[0]].to_json)
    end
    it 'returns results based on boro params' do
      request.env['HTTP_ACCEPT'] = 'application/json'
      get :index, boro: 'Manhattan'
      expect(response.body).to eq(@restaurants.to_json)
    end
    it 'returns results based on cuisine type' do
      request.env['HTTP_ACCEPT'] = 'application/json'
      get :index, cuisine: 'filipino'
      expect(response.body).to eq([@restaurants[0]].to_json)
    end
  end

  describe 'GET #show' do
    before :each do
      boro = Boro.create!(name: 'Manhattan')
      cuisine = Cuisine.create!(description: 'Filipino')
      action = Action.create!(description: 'U')
      @restaurant = Restaurant.create!({
        dba: "Subway",
        current_grade: 'A',
        boro_id: boro.id,
        cuisine_id: cuisine.id
        })
      inspection_one = Inspection.create!(score: 15)
      inspection_two = Inspection.create!(score: 12)
      violation_one = Violation.create!(critical_violation: true, code: '6A')
      violation_two = Violation.create!(critical_violation: false, code: '6B')
      inspection_one.violations << violation_one
      inspection_two.violations << violation_two
      action.inspections << inspection_one
      action.inspections << inspection_two
      @restaurant.inspections << inspection_one << inspection_two
    end
    it 'responds successfully with an HTTP 200 status code' do
      get :show, id: @restaurant.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it 'loads all of the restaurant data into @restaurant' do
      get :show, id: @restaurant.id
      expect(assigns(:restaurant)).to match(@restaurant)
    end
    it 'responds to requests for json' do
      request.env['HTTP_ACCEPT'] = 'application/json'
      expected_result = @restaurant.to_json(include: {
        inspections: { include: :violations }
        })
      get :show, id: @restaurant.id
      expect(response.body).to eq(expected_result)
    end
    it 'responds to requests for xml' do
      request.env['HTTP_ACCEPT'] = 'application/xml'
      expected_result = @restaurant.to_xml(include: {
        inspections: { include: :violations }
        })
      get :show, id: @restaurant.id
      expect(response.body).to eq(expected_result)
    end
  end
  DatabaseCleaner.clean
end
