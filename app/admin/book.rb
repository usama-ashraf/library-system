ActiveAdmin.register Book do
  
  permit_params :id, :title, :sub_title, :statement_resource, :author, :sub_author, :book_type, :account_no, :price,
                :entry_date, :ddc_no, :auth_mark, :section, :book_reference, :book_publisher, :place,
                :book_year, :book_source, :book_edition, :book_volume, :book_pages, :series, :language,
                :isbn, :binding, :cd_flopy, :status, :remarks, :content, :notes, :subject, :keyword, :suggested_by, :discipline, :shipping_charges


end
