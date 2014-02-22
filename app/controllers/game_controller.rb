class GameController < ApplicationController
  def index
    redirect_to game_url SecureRandom.urlsafe_base64(5, false)
  end

  def show
    @game_id = params[:game_id]
  end
end
