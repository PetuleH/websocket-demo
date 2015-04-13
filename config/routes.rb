SockChat::Application.routes.draw do
  devise_for :users
  root to: 'chat#index'
  get '/chat' => 'chat#chat'
  get '/send_message' => 'chat#send_message'
  sockets_for :messages
end
