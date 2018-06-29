class SearchController < ApplicationController
  def index
    if params[:email]
      @users = User.where('email LIKE ?', "%#{params[:email]}%")
    else
      @users = User.all
    end
  end
end
