class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def get_error(object)
    "#{object.errors.full_messages.first}"
  end
end
