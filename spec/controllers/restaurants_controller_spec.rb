require 'rails_helper'

RSpec.describe Api::RestaurantsController, type: :controller do
  describe 'GET #index' do
    restaurants = []
    before do
      boro = Boro.create!(name: 'Manhattan')
      cuisine = Cuisine.create!(description: 'Filipino')
      cuisine_two = Cuisine.create!(description: 'American')
      restaurants = [
        Restaurant.create!({
          dba: "Subway",
          current_grade: 'A',
          boro_id: boro.id,
          cuisine_id: cuisine.id
          }),
        Restaurant.create!({
          dba: "Subway",
          current_grade: 'B',
          boro_id: boro.id,
          cuisine_id: cuisine.id
          }),
        Restaurant.create!({
          dba: "India",
          current_grade: 'A',
          boro_id: boro.id,
          cuisine_id: cuisine_two.id
          })
        ]
    end
    
    it 'responds successfully with an HTTP 200 status code' do
      get :index, format: :json
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'loads all restaurants into @restaurants' do
      get :index, format: :json, all: 'true'
      expect(assigns(:restaurants)).to match_array(restaurants)
    end
    
    context 'a request is made for json' do
      it 'responds with json' do
        get :index, format: :json, all: true
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'a request is made for xml' do
      it 'reponds to requests for xml' do
        get :index, format: :xml, all: 'true'
        expect(response.content_type).to eq('application/xml')
      end
    end
    context 'params provided with request' do
      it 'returns results based on params' do
        get :index, format: :json, dba: 'Subway'
        subways = restaurants.take(2)
        expect(assigns(:restaurants)).to match_array(subways)
      end

      it 'returns results based on multiple params' do
        get :index, dba: 'Subway', current_grade: 'a', format: :json
        subway = [restaurants.first]
        expect(assigns(:restaurants)).to match(subway)
      end

      it 'returns results based on boro params' do
        get :index, boro: 'Manhattan', format: :json
        expect(assigns(:restaurants)).to eq(restaurants)
      end

      it 'returns results based on cuisine type' do
        get :index, cuisine: 'filipino', format: :json
        filipino = restaurants.take(2)
        expect(assigns(:restaurants)).to eq(filipino)
      end
    end
  end

  # describe 'GET #show' do
  #   before :each do
  #     boro = Boro.create!(name: 'Manhattan')
  #     cuisine = Cuisine.create!(description: 'Filipino')
  #     action = Action.create!(description: 'U')
  #     @restaurant = Restaurant.create!({
  #       dba: "Subway",
  #       current_grade: 'A',
  #       boro_id: boro.id,
  #       cuisine_id: cuisine.id
  #       })
  #     inspection_one = Inspection.create!(score: 15)
  #     inspection_two = Inspection.create!(score: 12)
  #     violation_one = Violation.create!(critical_violation: true, code: '6A')
  #     violation_two = Violation.create!(critical_violation: false, code: '6B')
  #     inspection_one.violations << violation_one
  #     inspection_two.violations << violation_two
  #     action.inspections << inspection_one
  #     action.inspections << inspection_two
  #     @restaurant.inspections << inspection_one << inspection_two
  #   end
  #   it 'responds successfully with an HTTP 200 status code' do
  #     get :show, id: @restaurant.id
  #     expect(response).to be_success
  #     expect(response).to have_http_status(200)
  #   end
  #   it 'loads all of the restaurant data into @restaurant' do
  #     get :show, id: @restaurant.id
  #     expect(assigns(:restaurant)).to match(@restaurant)
  #   end
  #   it 'responds to requests for json' do
  #     request.env['HTTP_ACCEPT'] = 'application/json'
  #     expected_result = @restaurant.to_json(include: {
  #       inspections: { include: :violations }
  #       })
  #     get :show, id: @restaurant.id
  #     expect(response.body).to eq(expected_result)
  #   end
  #   it 'responds to requests for xml' do
  #     request.env['HTTP_ACCEPT'] = 'application/xml'
  #     expected_result = @restaurant.to_xml(include: {
  #       inspections: { include: :violations }
  #       })
  #     get :show, id: @restaurant.id
  #     expect(response.body).to eq(expected_result)
  #   end
  # end
  # describe 'GET #by_camis' do
  #   before :each do
  #     boro = Boro.create!(name: 'Manhattan')
  #     cuisine = Cuisine.create!(description: 'Filipino')
  #     action = Action.create!(description: 'U')
  #     @restaurant = Restaurant.create!({
  #       camis: 12345678,
  #       dba: "Subway",
  #       current_grade: 'A',
  #       boro_id: boro.id,
  #       cuisine_id: cuisine.id
  #       })
  #     inspection_one = Inspection.create!(score: 15)
  #     inspection_two = Inspection.create!(score: 12)
  #     violation_one = Violation.create!(critical_violation: true, code: '6A')
  #     violation_two = Violation.create!(critical_violation: false, code: '6B')
  #     inspection_one.violations << violation_one
  #     inspection_two.violations << violation_two
  #     action.inspections << inspection_one
  #     action.inspections << inspection_two
  #     @restaurant.inspections << inspection_one << inspection_two
  #   end
  #   it 'responds successfully with an HTTP 200 status code' do
  #     expect(response).to be_success
  #     expect(response).to have_http_status(200)
  #   end
  #   it 'loads the restaurant data into @restaurant' do
  #     get :by_camis, camis: 12345678
  #     expect(assigns(:restaurant)).to match(@restaurant)
  #   end
  #   context 'returns a restaurant based on camis number' do
  #     it 'returns a restaurant with a valid camis' do
  #       request.env['HTTP_ACCEPT'] = 'application/json'
  #       expected_result = @restaurant.to_json(include: {
  #         inspections: { include: :violations }
  #         })
  #       get :by_camis, camis: 12345678
  #       expect(response.body).to eq(expected_result)
  #     end
  #     it 'returns a 400 code if the camis does not exist' do
  #       request.env['HTTP_ACCEPT'] = 'application/json'
  #       get :by_camis, camis: 87654321
  #       expect(response).to_not be_success
  #       expect(response).to have_http_status(400)
  #     end
  #   end
  # end
  DatabaseCleaner.clean
end
