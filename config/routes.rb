SockChat::Application.routes.draw do
  devise_for :users
  root to: 'chat#index'
  get '/chat' => 'chat#chat'
  sockets_for :messages
end
