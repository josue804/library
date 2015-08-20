require 'sinatra'
require 'pg'
require 'sinatra/reloader'
require './lib/book'
require './lib/patron'
require './lib/checkout'
require 'pry'

DB = PG.connect({:dbname => 'library'})


get('/') do
	erb(:index)
end

get('/patrons/new') do
	erb(:patrons_form)
end

get('/patrons') do
	@patrons = Patron.all()
	erb(:patrons)
end

post('/patrons') do
	name = params.fetch('name')
	patron = Patron.new({:id => nil, :name => name, :total_fine => 0})
	patron.save()
	@patrons = Patron.all()
	erb(:patrons)
end

get('/patrons/:Invalid_login_info') do
	puts 'got here'
	@patrons = Patron.all()
	@message = params.fetch('Invalid_login_info')
	@message.gsub!('_', ' ')
	@message.gsub!(':', '')
	erb(:patrons)
end

post('/patrons/login') do
	if params['password'] == 'password'
		@id = params.fetch('id').to_i()
		@patron = Patron.find(@id)
		erb(:patron)
	else
		message = 'Invalid login info'
		redirect('/patrons/:Invalid_login_info')
	end

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
