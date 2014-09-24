class API::RestaurantsController < ApplicationController

  def index
    if request_params.keys.join(',').match /(dba|cuisine|boro|current_grade)/
      @restaurants = Restaurant.fetch(request_params)
    else
      @restaurants = Restaurant.all
    end
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @restaurants.to_json }
      format.xml  { render xml: @restaurants.to_xml }
    end
  end

  private

  def request_params
    params.permit(:dba, :current_grade, :boro, :cuisine)
  end

end
