class API::ViolationsController < ApplicationController

  def index
    @violations = Violation.all
    respond_to do |format|
      format.html { render nothing: true }
      format.json { render json: @violations }
      format.xml { render xml: @violations }
    end
  end
end
