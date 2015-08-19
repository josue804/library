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
end
