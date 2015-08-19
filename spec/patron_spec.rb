require('spec_helper')


describe Patron do

  before do
    @name = Patron.new({ :name => 'Patron', :total_fine => 9, :id => nil })
  end
  describe '#name' do
    it 'should return the name of the patron' do
      expect(@name.name).to eq 'Patron'
    end
  end
end
