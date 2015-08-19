class Patron
  attr_reader(:name, :total_fine, :id)

  define_method(:initialize) do |attributes|
    @name       = attributes[:name]
    @total_fine = attributes[:total_fine]
    @id         = attributes[:id]
  end
end
