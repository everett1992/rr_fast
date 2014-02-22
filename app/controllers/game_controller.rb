class GameController < ApplicationController
  def index
    redirect_to game_url SecureRandom.urlsafe_base64
  end

  def show
    @game_id = params[:game_id]
  end
end
