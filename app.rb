require 'sinatra'
require 'pg'
require 'sinatra/reloader'
require './lib/book'
require './lib/patron'
require './lib/checkout'

DB = PG.connect({:dbname => 'library'})


get('/') do
	erb(:index)
end

get('/patrons/new') do
	erb(:patrons_form)
end

get('/patrons') do
	erb(:patrons)
end

post('/patrons') do
	erb(:patrons)
end

get('/patrons/:id/checkouts/new') do
	erb(:checkouts_form)
end

get('/patrons/:id/checkouts') do
	erb(:checkouts)
end

post('/patrons/:id/checkouts') do
	erb(:checkouts)
end
