class Book < ApplicationRecord
  has_many :reserve_books
  has_many :users, through: :reserve_books
end
