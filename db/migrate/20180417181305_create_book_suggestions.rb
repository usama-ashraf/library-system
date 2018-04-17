class CreateBookSuggestions < ActiveRecord::Migration[5.0]
  def change
    create_table :book_suggestions do |t|
      t.string :book_name
      t.string :author_name
      t.integer :user_id

      t.timestamps
    end
  end
end
