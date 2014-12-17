require 'sinatra'
require 'sinatra/reloader'
require_relative 'set_models'

enable :sessions
use Rack::Session::Pool, expire_after: 2_592_000

get '/' do
  session[:board] = Board.new(Deck.new)
  session[:start] = Time.now
  unless session[:board].any_sets?
    3.times { session[:board].draw_card }
  end
  erb :index
end

get '/guess' do
  cards = params['cards'].map { |a| a.to_i }
  session[:board].choose_set(cards[0], cards[1], cards[2])
end

get '/set' do
  until session[:board].any_sets? || session[:board].deck.empty?
    3.times {session[:board].draw_card}
  end
  if session[:board].any_sets?
    erb :index
  else
    end_time = Time.now
    time = (end_time - session[:start]).to_i
    @minutes = time / 60
    @seconds = time % 60
    erb :win
  end
end
