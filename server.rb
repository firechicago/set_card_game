require 'sinatra'
require_relative 'set_models'

get '/' do
  @board = Board.new(Deck.new)
  erb :index
end
