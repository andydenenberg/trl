class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => :welcome

  def welcome
  end

  def start 
  end
  
  def index
    @users = User.all
  end

end