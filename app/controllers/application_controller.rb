class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def set_flash_error(object)
    object.errors.full_messages.each { |error| flash.now[:error] = error }
  end
end
