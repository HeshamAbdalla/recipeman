class PagesController < ApplicationController
  def home
    @users = User.all
    redirect_to recipes_path if logged_in?
  end
end
