class Checkout

  attr_reader :id, :patron_id, :book_id, :due_date, :fine

  define_method(:initialize) do |attributes|
    @id        = attributes[:id]
    @patron_id = attributes[:patron_id]
    @book_id   = attributes[:book_id]
    @due_date  = Time.new(attributes[:due_date])
    @fine      = attributes[:fine]
  end


  define_singleton_method(:all) do
    returned_checkouts = DB.exec("SELECT * FROM checkouts;")
    checkouts = []
    returned_checkouts.each() do |checkout|
      id = checkout['id'].to_i()
      patron_id = checkout['patron_id'].to_i()
      book_id = checkout['book_id'].to_i()
      due_date = checkout['due_date']
      fine = checkout['fine'].to_i()
      checkouts.push(Checkout.new({:id => id, :patron_id => patron_id, :book_id => book_id, :due_date => due_date, :fine => fine}))
    end
    checkouts
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO checkouts (patron_id, book_id, due_date, fine) VALUES (#{@patron_id}, #{@book_id}, '#{@due_date}', #{@fine}) RETURNING id;")
    @id = result.first.fetch('id').to_i()
  end

  define_method(:==) do |other|
    id() == other.id() && patron_id() == other.patron_id() && book_id() == other.book_id() && due_date == other.due_date()
  end

  define_method(:delete) do
    DB.exec("DELETE FROM checkouts * WHERE id = #{@id};")
  end

  define_method(:update) do |attributes|
    @patron_id = attributes[:patron_id]
    @book_id = attributes[:book_id]
    @due_date = Time.new(attributes[:due_date])
    @fine = attributes[:fine]
    DB.exec("UPDATE checkouts SET patron_id = #{@patron_id}, book_id = #{}")
  end

end
