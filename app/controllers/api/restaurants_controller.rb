module Api
  class RestaurantsController < ApplicationController

    def index
      param_regex = /(dba|cuisine|boro|current_grade|zip_code)/
      if request_params.keys.join(',').match param_regex
        @restaurants = Restaurant.fetch(request_params)
      else
        @restaurants = Restaurant.all
      end
      respond_to do |format|
        format.html {}
        format.json do
          if @restaurants.nil?
            render json: 'Error: Bad Request', status: 400
          else
            render json: @restaurants, status: 200
          end
        end
        format.xml do
          if @restaurants.nil?
            render xml: 'Error: Bad Request', status: 400
          else
            render xml: @restaurants, status: 200
          end
        end
      end
    end

    def show
      @restaurant = Restaurant.find_by(request_params)
      respond_to do |format|
        format.html {}
        format.json do
          if @restaurant.nil?
            render json: 'Error: Bad Request', status: 400
          else
            render json: @restaurant.to_json(include: {
              inspections: { include: :violations }
              }), status: 200
          end
        end
        format.xml do
          if @restaurant.nil?
            render xml: 'Error: Bad Request', status: 400
          else
            render xml: @restaurant.to_xml(include: {
              inspections: { include: :violations }
              }), status: 200
          end
        end
      end
    end

    def by_camis
      @restaurant = Restaurant.find_by(camis: request_params[:camis])
      respond_to do |format|
        format.html {}
        format.json do
          if @restaurant.nil?
            render json: 'Error: Bad CAMIS', status: 400
          else
            render json: @restaurant.to_json(include: {
              inspections: { include: :violations }
              }), status: 200
          end
        end
        format.xml do
          if @restaurant.nil?
            render xml: 'Error: BAD CAMIS', status: 400
          else
            render xml: @restaurant.to_xml(include: {
              inspections: { include: :violations }
              }), status: 200
          end
        end
      end
    end

    private

    def request_params
      params.permit(:dba, :current_grade, :boro, :cuisine, :id, :zip_code, :camis)
    end

  end
end
