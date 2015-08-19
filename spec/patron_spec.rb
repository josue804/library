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
end
