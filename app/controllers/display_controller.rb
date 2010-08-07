class DisplayController < ApplicationController
  before_filter :coach_check

  def index
    @no_admin = true
  end

  protected

  def coach_check
    authenticate_or_request_with_http_basic do |username, password|
      username == "coach" && password == "adaptation"
    end
  end

end
