class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  # include ActionView::Layouts
  def index
    render layout: 'application', text: ''
  end
end
