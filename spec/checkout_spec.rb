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
end
