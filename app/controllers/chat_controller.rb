class ChatController < WebsocketRails::BaseController
  include ActionView::Helpers::SanitizeHelper

  def new_user
    logger.info '--------------'
    connection_store[:user] = {
      user_name: (message[:user_name]),
      points: (message[:points])
    }
    game = controller_store[:game]
    if game
      send_message :get_game, game
      broadcast_user_list
    end
  end

  def set_game
    controller_store[:game] = message
  end

  def change_username
    connection_store[:user][:user_name] = (message[:user_name])
    broadcast_user_list
  end

  def broadcast_user_list
    users = connection_store.collect_all(:user)
    logger.info users
    broadcast_message :user_list, users
  end
end
