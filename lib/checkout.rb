class Checkout

  attr_reader :id, :patron_id, :book_id, :due_date, :fine

  define_method(:initialize) do |attributes|
    @id        = attributes['id']
    @patron_id = attributes['patron_id']
    @book_id   = attributes['book_id']
    @due_date  = attributes['due_date']
    @fine      = attributes['fine']
  end


  define_singleton_method(:all) do
    returned_checkouts = DB.exec("SELECT * FROM checkouts;")
    checkouts = []
    returned_checkouts.each() do |checkout|
      id = checkout['id'].to_i()
      patron_id = checkout['patron_id'].to_i()
      book_id = checkout['book_id'].to_i()
      due_date = Time.new(checkout['due_date'])
      fine = checkout['fine'].to_i()
      checkouts.push(:id => id, :patron_id => patron_id, :book_id => book_id, :due_date => due_date, :fine => fine)
    end
    checkouts
  end

end
