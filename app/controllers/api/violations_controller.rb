module Api
  class ViolationsController < ApplicationController

    def index
      @violations = Violation.all
      respond_to do |format|
        # format.html {}
        format.json { render json: @violations, status: 200 }
        format.xml  { render xml: @violations, status: 200 }
      end
    end
  end
end
