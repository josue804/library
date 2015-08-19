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
   
end
