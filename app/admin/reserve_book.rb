ActiveAdmin.register ReserveBook do
  permit_params :id, :user_id, :book_id, :status, :issue_date, :due_date
  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Information' do
      f.input :status
      f.input :issue_date ,as: :datepicker,
          datepicker_options: {
          min_date: Date.today
      }
      f.input :due_date ,as: :datepicker,
              datepicker_options: {
                  min_date: Date.today
              }
      f.input :user_id, :as => :selectize, :collection => User.all.map{|u| ["#{u.email}", u.id]}
      f.input :book_id, :as => :selectize, :collection => Book.all.map{|u| ["#{u.title}", u.id]}
    end
    f.actions
  end
  
end