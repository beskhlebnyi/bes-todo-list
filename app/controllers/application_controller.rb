class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :set_locale
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def set_flash_error(object)
    object.errors.full_messages.each { |error| flash.now[:error] = error }
  end

  def self.default_url_options(options={})
    options.merge({ :locale => I18n.locale })
  end

end
