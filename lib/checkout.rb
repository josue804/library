class Checkout

  attr_reader :id, :patron_id, :book_id, :due_date, :fine

  define_method(:initialize) do |attributes|
    @id = attributes['id']
    @patron_id = attributes['patron_id']
    @book_id = attributes['book_id']
    @fine = attributes['fine']
  end


end
