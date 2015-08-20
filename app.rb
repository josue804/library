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

# Books

get('/books/authors') do
	@books = Book.all
	erb(:author_form)
end

post('/books/authors') do
	genre = params.fetch('genre')
	@books = Book.find_by_genre(genre)
	erb(:browse)
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

get('/patrons/login/error') do
	@patrons = Patron.all()
	@message = 'Your form has some errors'
	erb(:patrons)
end

post('/patrons/login') do
	if params['password'] == 'password'
		@id = params.fetch('id').to_i()
		@patron = Patron.find(@id)
		erb(:patron)
	else
		redirect('/patrons/login/error')
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

get('/librarians') do
	@books = Book.all()
	erb(:librarians)
end

post('/librarians') do
	@books = Book.all()
	erb(:librarians)
end

get('/librarians/books') do
	@books = Book.all()
	erb(:librarian_books)
end

post('/librarians/books') do
	title            = params.fetch('title')
	author           = params.fetch('author')
	pages            = params.fetch('pages').to_i()
	publication_year = params.fetch('publication_year').to_i()
	genre = params.fetch('genre')
	book = Book.new({:title => title, :author => author, :pages => pages, :publication_year => publication_year, :genre => genre})
	book.save()
	@books = Book.all()
	erb(:librarian_books)
end

get('/librarians/:id') do
	@books = Book.all()
	@to_delete = Book.find(params.fetch('id').to_i())
	@to_delete.each{|each| each.delete()}
	erb(:librarian_books)
end

post('/librarians/login') do
	if params['password'] == 'password'
		erb(:librarian)
	else
		redirect('/librarians/login/error')
	end
end

get('/librarians/login/error') do
	@message = 'Your form has some errors.'
	erb(:librarians)
end

get('/librarians/:id/edit') do
	@id                = params['id'].to_i()
	@book              = Book.find(@id).first
	@author 				   = @book.author
	@title  					 = @book.title
	@pages  					 = @book.pages
	@publication_year  = @book.publication_year
	@genre  					 = @book.genre
	erb(:book_edit)
end

patch('/librarians/:id/edit') do
	id               = params['id'].to_i()
	author 				   = params['author']
	title  					 = params['title']
	pages  					 = params['pages'].to_i()
	publication_year = params['publication_year'].to_i()
	genre  					 = params['genre']
	@book            = Book.find(id).first
	@book.update({ :id => id, :author => author, :title => title, :pages => pages, :publication_year => publication_year, :genre => genre })
	erb(:librarian)
end
