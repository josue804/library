class Book
   attr_reader :id, :author, :title, :pages, :publication_year, :genre

   define_method(:initialize) do |attributes|
     @id               = attributes[:id]
     @author           = attributes[:author]
     @title            = attributes[:title]
     @pages            = attributes[:pages]
     @publication_year = attributes[:publication_year]
     @genre            = attributes[:genre]
   end


   define_singleton_method(:all) do
     returned_books = DB.exec("SELECT * FROM books;")
     books = []
     returned_books.each() do |returned_book|
       id               = returned_book['id'].to_i()
       author           = returned_book['author']
       title            = returned_book['title']
       pages            = returned_book['pages'].to_i()
       publication_year = returned_book['publication_year'].to_i()
       genre            = returned_book['genre']
       books.push(Book.new({:id => id, :author => author, :title => title, :pages => pages, :publication_year => publication_year, :genre => genre}))
     end
     books
   end

   define_method(:save) do
     result = DB.exec("INSERT INTO books (author, title, pages, publication_year, genre) VALUES ('#{author}', '#{title}', #{pages}, #{publication_year}, '#{genre}') RETURNING id;")
     @id    = result.first.fetch('id').to_i()
   end

   define_method(:==) do |other|
     id() == other.id() && author() == other.author() && title() == other.title() && pages() == other.pages() && publication_year() == other.publication_year() && genre() == other.genre()
   end

   define_method(:update) do |attributes|
     @author           = attributes.fetch(:author)
     @title            = attributes.fetch(:title)
     @pages            = attributes.fetch(:pages)
     @publication_year = attributes.fetch(:publication_year)
     @genre            = attributes.fetch(:genre)
     DB.exec("UPDATE books SET author = '#{@author}', title = '#{@title}', pages = '#{@pages}', publication_year = #{@publication_year}, genre = '#{@genre}' WHERE id = #{@id};")
   end

   define_method(:delete) do
     DB.exec("DELETE FROM books * WHERE id = #{id};")
     DB.exec("DELETE FROM checkouts * WHERE book_id = #{id};")
   end

   define_singleton_method(:find_by_genre) do |genre|
     returned_books = DB.exec("SELECT * FROM books WHERE genre = '#{genre}';")
     books = []
     returned_books.each() do |returned_book|
       id               = returned_book['id'].to_i()
       author           = returned_book['author']
       title            = returned_book['title']
       pages            = returned_book['pages'].to_i()
       publication_year = returned_book['publication_year'].to_i()
       genre            = returned_book['genre']
       books.push(Book.new({:id => id, :author => author, :title => title, :pages => pages, :publication_year => publication_year, :genre => genre}))
     end
     books
   end
end
