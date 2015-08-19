class Patron
  attr_reader(:name, :total_fine, :id)

  define_method(:initialize) do |attributes|
    @name       = attributes[:name]
    @total_fine = attributes[:total_fine]
    @id         = attributes[:id]
  end


  define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons          = []
    returned_patrons.each() do |returned_patron|
      name       = returned_patron['name']
      total_fine = returned_patron['total_fine'].to_i()
      id         = returned_patron['id'].to_i()
      patrons.push(Patron.new({:name => name, :total_fine => total_fine, :id => id}))
    end
    patrons
  end

  define_method(:save) do
    return_patrons = DB.exec("INSERT INTO patrons (name, total_fine) VALUES ('#{@name}', #{@total_fine}) RETURNING id;")
    @id = return_patrons.first.fetch('id').to_i()
  end

  define_method(:==) do |other|
    name() == other.name() && total_fine() == other.total_fine
  end

  define_method(:checkouts) do
    returned_checkouts = DB.exec("SELECT * FROM checkouts WHERE patron_id = #{@id};")
    checkouts          = []
    returned_checkouts.each() do |returned_checkout|
      id        = returned_checkout['id'].to_i()
      patron_id = returned_checkout['patron_id'].to_i()
      book_id   = returned_checkout['book_id'].to_i()
      due_date  = Time.new(returned_checkout['due_date'])
      fine      = returned_checkout['fine'].to_i()
      checkouts.push(Checkout.new(:id => id, :patron_id => patron_id, :book_id => book_id, :due_date => due_date, :fine => fine))
    end
    checkouts
  end
end
