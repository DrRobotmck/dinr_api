module Api
  class ActionsController < ApplicationController

    def index
      @actions = Action.all
      respond_to do |format|
        format.html { render 'public/bad_request', status: 400 }
        format.json { render json: @actions.to_json, status: 200 }
        format.xml  { render xml: @actions.to_xml, status: 200 }
      end
    end
  end
end
