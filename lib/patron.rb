class Patron
  attr_reader(:name, :total_fine, :id)

  define_method(:initialize) do |attributes|
    @name       = attributes[:name]
    @total_fine = attributes[:total_fine]
    @id         = attributes[:id]
  end


  define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each() do |returned_patron|
      name       = returned_patron['name']
      total_fine = returne_patron['total_fine'].to_i()
      id         = returned_patron['id'].to_i()
      patrons.push(Patron.new({:name => name, :total_fine => total_fine, :id => id}))
    end
    patrons
  end
end
