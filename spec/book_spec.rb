require('spec_helper')


describe(Book) do

  before do
    @book = Book.new({:id => nil, :author => 'Author', :title => 'Title', :pages => 100, :publication_year => 1999, :genre => 'Genre'})
  end


  describe('#id') do
    it('should return the id of the book') do
      expect(@book.id()).to(eq(nil))
    end
  end

  describe('#author') do
    it('should return the author of the book') do
      expect(@book.author()).to(eq('Author'))
    end
  end

  describe('#pages') do
    it('should return the pages of the book') do
      expect(@book.pages()).to(eq(100))
    end
  end

  describe('#publication_year') do
    it('should return the publication_year of the book') do
      expect(@book.publication_year()).to(eq(1999))
    end
  end

  describe('#genre') do
    it('should return the genre of the book') do
      expect(@book.genre()).to(eq('Genre'))
    end
  end

  describe('.all') do
    it('should return all of the saved books (empty at first)') do
      expect(Book.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('should save a book onto the Book database') do
      @book.save()
      expect(Book.all()).to(eq([@book]))
    end
  end

  describe('#update') do
    it('lets you update books in the database') do
      @book.save()
      @book.update({:id => nil, :author => 'Jon Krakauer', :title => 'Into Thin Air', :pages => 300, :publication_year => 1997, :genre => 'Adventure Non-Fiction'})
      expect(@book.title()).to(eq("Into Thin Air"))
      expect(@book.author()).to(eq("Jon Krakauer"))
    end
  end

  describe('#delete') do
    it('removes the book from the db') do
      @book.save()
      @book.delete()
      expect(Book.all()).to(eq([]))
    end

    it('removes associated checkouts but not associated patrons') do
      @book.save()
      patron   = Patron.new({:name => 'Patron', :total_fine => 0, :id => nil})
      patron.save()
      checkout = Checkout.new(:id => nil, :patron_id => patron.id(), :book_id => @book.id(), :due_date => '2015-08-22', :fine => 1)
      checkout.save()
      @book.delete()
      expect(Book.all()).to(eq([]))
      expect(Checkout.all()).to(eq([]))
      expect(Patron.all()).to(eq([patron]))
    end
  end
end
