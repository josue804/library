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

  describe '.all' do
    it 'should be empty at first' do
      expect(Patron.all()).to eq []
    end
  end
end
