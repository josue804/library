require 'sinatra'
require 'pg'
require 'sinatra/reloader'
require './lib/book'
require './lib/patron'
require './lib/checkout'

DB = PG.connect({:dbname => 'library'})


get '/'  do
	erb :index
end
