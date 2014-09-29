module Api
  class ActionsController < ApplicationController

    def index
      @actions = Action.all
      respond_to do |format|
        format.html {}
        format.json { render json: @actions, status: 200 }
        format.xml  { render xml: @actions, status: 200 }
      end
    end
  end
end
