class ApplicationController < ActionController::Base
  # before any action perform by the application controller basically any action in the UI, we need an authenticated user
  protect_from_forgery with: :exception
  before_action :authenticate_user!
end
