class ChatController < WebsocketRails::BaseController
  include ActionView::Helpers::SanitizeHelper

  def new_user
    connection_store[:user] = {
      user_name: message[:user_name],
      points: message[:points],
      best_solution: message[:best_solution]
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

  def solve
    logger.info "---------"
    logger.info "solved by #{message[:user_name]}"

    moves = connection_store.collect_all(:user).map { |user| user[:best_solution] }
    unless moves.any? { |m| !m.nil? }
      controller_store[:game][:end_time] = 1.minute.from_now
      broadcast_message :set_end, controller_store[:game][:end_time].to_i * 1000
    end

    connection_store[:user] = {
      user_name: message[:user_name],
      points: message[:points],
      best_solution: message[:best_solution]
    }
    broadcast_user_list

  end

  def broadcast_user_list
    users = connection_store.collect_all(:user)
    broadcast_message :user_list, users
  end
  def end_round
    user = connection_store.collect_all(:user).sort_by { |user| user[:best_solution].try(:length)||2000000 }.first
    #The above workaround is only there because this is a hackathon.
    #Also, it's numberwang.
    send_message :declare_winner, user
  end
  def next_round
    user = connection_store.collect_all(:user).sort_by { |user| user[:best_solution].try(:length)||2000000 }.first
    user[:points] += 1
    connection_store.collect_all(:user).each { |user| user[:best_solution]= nil }
    broadcast_user_list
    broadcast_message :next_round, true
  end
end
