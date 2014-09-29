module Api
  class RestaurantsController < ApplicationController

    def index
      param_regex = /(dba|cuisine|boro|current_grade|zip_code)/
      if request.params[:all] == 'true'
        @restaurants = Restaurant.all
      elsif request_params.keys.join(',').match param_regex
        @restaurants = Restaurant.fetch(request_params)
      end
      respond_to do |format|
        format.html {}
        format.json {}
        format.xml  {}
      end
    end

    def show
      @restaurant = Restaurant.find_by(request_params)
      respond_to do |format|
        format.html {}
        format.json {}
        format.xml  {}
      end
    end

    def by_camis
      @restaurant = Restaurant.find_by(camis: params[:camis])
      respond_to do |format|
        format.html {}
        format.json {}
        format.xml  {}
      end
    end

    private

    def request_params
      params.permit(:dba, :current_grade, :boro, :cuisine, :id, :zip_code, :camis)
    end

  end
end
