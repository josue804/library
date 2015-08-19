require('spec_helper')


describe(Checkout) do

  before do
    @checkout = Checkout.new({:id => nil, :patron_id => 1, :book_id => 1, :due_date => '2015-08-22', :fine => 1})
  end

  describe('#id') do
    it('should return the id of the patron who checkout out the book') do
      expect(@checkout.id()).to eq nil
    end
  end

  describe('.all') do
    it('should return an empty array at first') do
      expect(Checkout.all()).to eq []
    end
  end

  describe('#save') do
    it('should save a checkout onto the checkouts table') do
      @checkout.save()
      expect(Checkout.all()).to eq [@checkout]
    end
  end

  describe('#delete') do
    it('should remove the checkout from the db') do
      @checkout.save()
      @checkout.delete()
      expect(Checkout.all()).to(eq([]))
    end
  end
end
