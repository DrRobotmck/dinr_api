module Api
  class RestaurantsController < ApplicationController
    def index
      if request_params.keys.join(',').match /(dba|cuisine|boro|current_grade)/
        @restaurants = Restaurant.fetch(request_params)
      else
        @restaurants = Restaurant.all
      end
      respond_to do |format|
        format.html { render 'public/bad_request', status: 400 }
        format.json { render json: @restaurants, status: 200 }
        format.xml  { render xml: @restaurants, status: 200 }
      end
    end

    def show
      @restaurant = Restaurant.find_by(request_params)
      respond_to do |format|
        format.html { render 'public/bad_request', status: 400 }
        format.json do
          render json: @restaurant.to_json(include: {
            inspections: { include: :violations }
            }), status: 200
        end
        format.xml do
          render xml: @restaurant.to_xml(include: {
            inspections: { include: :violations }
            }), status: 200
        end
      end
    end

    private

    def request_params
      params.permit(:dba, :current_grade, :boro, :cuisine, :id)
    end

  end
end
