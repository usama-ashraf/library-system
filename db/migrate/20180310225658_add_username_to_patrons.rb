class AddUsernameToPatrons < ActiveRecord::Migration[5.0]
  def change
    add_column :patrons, :username, :string
    add_index :patrons, :username, unique: true
  end
end
