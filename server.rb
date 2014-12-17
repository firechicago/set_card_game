require 'sinatra'
require 'sinatra/reloader'
require_relative 'set_models'
require 'pry'

enable :sessions
use Rack::Session::Pool, :expire_after => 2592000


get '/' do
  session[:board] = Board.new(Deck.new)
  unless session[:board].any_sets?
    3.times {session[:board].draw_card}
  end
  # binding.pry
  erb :index
end

get '/guess' do
  # binding.pry
  cards = params['cards'].map {|a| a.to_i}
  # binding.pry
  session[:board].choose_set(cards[0], cards[1], cards[2])
end

get '/set' do
  erb :index
end
