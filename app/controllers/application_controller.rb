class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # before any action perform by the application controller basically any action in the UI, we need an authenticated user
  before_action :authenticate_user!
end