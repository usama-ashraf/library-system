class BooksController < ApplicationController

  def upload_books_csv

  end

  def add_books_data
    if params[:books_data][:uploaded_file].present?
      require 'csv'

      csv_text = File.read(params[:books_data][:uploaded_file].path)
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        puts row
        puts row["TITLE"]
        book = Book.where(account_no: row["ACCNO"])
        puts book
        if book.present?
          # do nothing
        else
          if row["ENTRYDATE"].present?
            begin
              date = row["ENTRYDATE"].to_date
            rescue ArgumentError => e
              date = row["ENTRYDATE"]
            end
          else
            puts row["ENTRYDATE"]
            date = row["ENTRYDATE"]
          end

          @book = Book.create(title: row[0], sub_title: row["SUBTITLE"], author: row["AUTHOR"], sub_author: row["SUBAUTHOR"], book_type: row["TYPE"], account_no: row["ACCNO"], price: row["PRICE"], entry_date: date, ddc_no: row["DDC_NO"], auth_mark: row["AUTH_MARK"], book_reference: row["REFERENCE"].downcase, book_publisher: row["PUBLISHER"], place: row["PLACE"], book_year: row["YEAR"], book_source: row["SOURCE"], book_edition: row["EDITION"], book_volume: row["VOLUME"], book_pages: row["PAGES"], series: row["SERIES"], language: row["LANGUAGE"], isbn: row["ISBN"], binding: row["BINDING"], cd_flopy: row["CD_FLOPY"], remarks: row["REMARKS"], content: row["Contents"], notes: row["Notes"], subject: row["subject"], keyword: row["keywords"], suggested_by: row["Suggestedby"], section: row["Section"], discipline: row["Discipline_sahlib"], shipping_charges: row["ShippingCharges"])
        end
      end
      redirect_to upload_books_csv_books_path(id: 1), success: "Books data added successfully"
    end
  end
end
