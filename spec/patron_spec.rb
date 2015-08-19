require('spec_helper')


describe Patron do

  before do
    @patron = Patron.new({ :name => 'Patron', :total_fine => 9, :id => nil })
  end

  describe '#name' do
    it 'should return the name of the patron' do
      expect(@patron.name).to eq 'Patron'
    end
  end

  describe '.all' do
    it 'should be empty at first' do
      expect(Patron.all()).to eq []
    end
  end

  describe '#save' do
    it 'should save the patron to the db' do
      @patron.save()
      expect(Patron.all()).to eq [@patron]
    end
  end

  describe '#==' do
    it 'should override the equality operator' do
      patron2 = Patron.new({:name => 'Patron', :total_fine => 9, :id => nil})
      expect(patron2).to eq @patron
    end
  end

  describe '#checkouts' do
    it 'patron has no checkouts at first' do
      @patron.save()
      expect(@patron.checkouts).to eq []
    end
  end

  describe '#update' do
    it 'lets you update the patron in the db' do
      @patron.save()
      @patron.update({ :name => 'Bob', :total_fine => 9, :id => nil })
      expect(@patron.name()).to(eq('Bob'))
    end
  end

  describe '#delete' do
    it 'deletes a patron' do
      @patron.save()
      @patron.delete()
      expect(Patron.all()).to(eq([]))
    end

    it 'deletes a patron and their dependencies' do
      @patron.save()
      book = Book.new({:id => nil, :author => 'John Steinbeck', :title => 'The Grapes of Wrath', :publication_year => 1936, :genre => 'Historical Fiction', :pages => 528})
      book.save()
      checkout = Checkout.new({:id => nil, :patron_id => @patron.id(), :book_id => book.id(), :due_date => '2015-09-14', :fine => 3})
      checkout.save()
      @patron.delete()
      expect(Checkout.all()).to(eq([]))
      expect(Patron.all()).to(eq([]))
    end
  end
end
