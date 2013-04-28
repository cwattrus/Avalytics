class HomeController < ApplicationController
  def home
    unless user_signed_in?
      return redirect_to new_user_session_path
    end
  end
end