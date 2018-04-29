class User < Patron
  devise :invitable, :registerable, :confirmable
  
  has_many :reserve_books
  has_many :books, through: :reserve_books
  has_many :book_suggestions
end
