class CreateReserveBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :reserve_books do |t|
      t.integer :user_id
      t.integer :book_id
      t.boolean :status, default: false
      t.date :issue_date
      t.date :due_date

      t.timestamps
    end
  end
end
