class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :sub_title
      t.string :statement_resource
      t.string :author
      t.string :sub_author
      t.string :book_type
      t.integer :account_no
      t.float :price
      t.date :entry_date
      t.float :ddc_no
      t.string :auth_mark
      t.string :section
      t.boolean :book_reference
      t.string :book_publisher
      t.string :place
      t.integer :book_year
      t.string :book_source
      t.string :book_edition
      t.string :book_volume
      t.integer :book_pages
      t.string :series
      t.string :language
      t.string :isbn
      t.string :binding
      t.string :cd_flopy
      t.string :status
      t.string :remarks
      t.string :content
      t.string :notes
      t.string :subject
      t.string :keyword
      t.string :suggested_by
      t.string :discipline
      t.string :shipping_charges

      t.timestamps
    end
  end
end
