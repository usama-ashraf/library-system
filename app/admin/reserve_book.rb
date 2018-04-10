ActiveAdmin.register ReserveBook do
  permit_params :id, :user_id, :book_id, :status, :issue_date, :due_date
  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Information' do
      f.input :status
      f.input :issue_date
      f.input :due_date
      f.input :user_id, :as => :select, :collection => User.all.map{|u| ["#{u.email}", u.id]}
      f.input :book_id, :as => :select, :collection => Book.all.map{|u| ["#{u.title}", u.id]}
    end
    f.actions
  end
  
end