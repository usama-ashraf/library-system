class Api::V1::UsersController < ApiProtectedController
  skip_before_action :verify_authenticity_token
  
  before_action only: [:update_student] do
    :authenticate_request!
  end
  
  def sign_in
    patron = Patron.find_by_username(params[:username])
    if patron && patron.valid_password?(params[:password])
      auth_token   = JsonWebToken.encode({ patron_id: patron.id })
      resp_data    = patron_response(patron, auth_token)
      resp_status  = 200
      resp_message = 'Success'
      resp_errors  = ''
    else
      resp_data    = ''
      resp_status  = 400
      resp_message = 'Please enter valid username or password'
      resp_errors  = 'Invalid username / password'
    end
    common_api_response(resp_data, resp_status, resp_message, resp_errors)
  end
  
  def search_book
    if params[:keyword].present? && params[:search_by].present?
      search = params[:keyword]
      if params[:search_by] == "keyword"
        @books = Book.where("title LIKE ? OR sub_title LIKE ? OR author LIKE ? OR sub_author LIKE ? OR section LIKE ? OR book_publisher LIKE ? OR place LIKE ? OR book_source LIKE ? OR book_edition LIKE ? OR series LIKE ? OR isbn LIKE ? OR subject LIKE ? OR keyword LIKE ? OR discipline LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
      elsif params[:search_by] == "title"
        @books = Book.where("title LIKE ?", "%#{search}%")
      elsif params[:search_by] == "author"
        @books = Book.where("author LIKE ?", "%#{search}%")
      elsif params[:search_by] == "subject"
        @books = Book.where("subject LIKE ?", "%#{search}%")
      elsif params[:search_by] == "series"
        @books = Book.where("series LIKE ?", "%#{search}%")
      elsif params[:search_by] == "isbn"
        @books = Book.where("isbn LIKE ?", "%#{search}%")
      elsif params[:search_by] == "callno"
        @books = Book.where("section LIKE ?", "%#{search}%")
      end
      if @books.present?
        resp_data    = books_response(@books)
        resp_status  = 200
        resp_message = 'Books list'
        resp_errors  = ''
      else
        resp_data    = ''
        resp_status  = 400
        resp_message = 'No books found'
        resp_errors  = 'No books found'
      end
      common_api_response(resp_data, resp_status, resp_message, resp_errors)
    else
      resp_data    = ''
      resp_status  = 400
      resp_message = 'Please add correct parameters'
      resp_errors  = 'Please add correct parameters'
      common_api_response(resp_data, resp_status, resp_message, resp_errors)
    end
  end
  
  def reserve_book
    if params[:book_id].present? && params[:user_id].present?
      reserverd_book = ReserveBook.new(user_id: params[:user_id], book_id: params[:book_id], status: false)
      if reserverd_book.save
        resp_data    = books_reserve(reserverd_book)
        resp_status  = 200
        resp_message = 'Books reserved successfully'
        resp_errors  = ''
      end
      common_api_response(resp_data, resp_status, resp_message, resp_errors)
    else
      resp_data    = ''
      resp_status  = 400
      resp_message = 'Book id or User id missing'
      resp_errors  = 'Book id or User id missing'
      common_api_response(resp_data, resp_status, resp_message, resp_errors)
    end
  end
  
  def show_book
    if params[:book_id].present?
      book = Book.find_by_id(params[:book_id])
      if book.present?
        resp_data    = book_details(book)
        resp_status  = 200
        resp_message = 'Book found successfully'
        resp_errors  = ''
      else
        resp_data    = ''
        resp_status  = 400
        resp_message = 'No books found'
        resp_errors  = 'No books found'
      end
      common_api_response(resp_data, resp_status, resp_message, resp_errors)
    else
      resp_data    = ''
      resp_status  = 400
      resp_message = 'Book id missing'
      resp_errors  = 'Book id missing'
      common_api_response(resp_data, resp_status, resp_message, resp_errors)
    end
  end
  
  def books_list
    books = Book.all
    if books.present?
      resp_data    = book_details(books)
      resp_status  = 200
      resp_message = 'Books found successfully'
      resp_errors  = ''
    else
      resp_data    = ''
      resp_status  = 400
      resp_message = 'No books found'
      resp_errors  = 'No books found'
    end
    common_api_response(resp_data, resp_status, resp_message, resp_errors)
  end
  
  def reserve_books
    books=ReserveBook.where(user_id: params[:user_id])
    if books.present?
      resp_data    = reserve_books_resp(books)
      resp_status  = 200
      resp_message = 'Books found successfully'
      resp_errors  = ''
    else
      resp_data    = ''
      resp_status  = 400
      resp_message = 'No books found'
      resp_errors  = 'No books found'
    end
    common_api_response(resp_data, resp_status, resp_message, resp_errors)
  end
  
  def book_suggestion
    book_suggestion =BookSuggestion.new(book_suggestion_params)
    if book_suggestion.save
      resp_data    = ''
      resp_status  = 200
      resp_message = 'Suggestion is created successfully'
      resp_errors  = ''
    else
      resp_data    = ''
      resp_status  = 400
      resp_message = 'Error'
      resp_errors  = 'Error'
    end
    common_api_response(resp_data, resp_status, resp_message, resp_errors)
  end
  
  # def destroy
  #   if params[:user_id].present?
  #     user = User.find_by_id(params[:user_id])
  #     if user.present?
  #       sign_out(user)
  #       resp_data    = ""
  #       resp_status  = 200
  #       resp_message = 'User signed out successfully'
  #       resp_errors  = ''
  #     else
  #       resp_data    = ''
  #       resp_status  = 400
  #       resp_message = 'User not found'
  #       resp_errors  = 'User not found'
  #     end
  #     common_api_response(resp_data, resp_status, resp_message, resp_errors)
  #   else
  #     resp_data    = ''
  #     resp_status  = 400
  #     resp_message = 'User id missing'
  #     resp_errors  = 'User id missing'
  #     common_api_response(resp_data, resp_status, resp_message, resp_errors)
  #   end
  # end
  
  # def reset_password
  #   student=Student.find_by_id(params[:student][:student_id])
  #   if student && student.valid_password?(params[:student][:password])
  #     student.password = params[:student][:new_password]
  #     student.save!
  #     resp_status  = 1
  #     resp_message = 'Password Successfully Reset.'
  #     resp_errors  = ''
  #     resp_data    = ''
  #   else
  #     resp_status  = 0
  #     resp_message = 'Error'
  #     resp_errors  = 'Your current password is incorrect.'
  #     resp_data    = ''
  #   end
  #   common_api_response(resp_data, resp_status, resp_message, resp_errors)
  # end
  #
  # def forgot_password
  #   begin
  #
  #     student = Student.find_by_email(params[:student][:email])
  #     if student.present?
  #       student.send_reset_password_instructions
  #       resp_status  = 1
  #       resp_message = 'Please check your email and follow the instructions.'
  #       resp_errors  = ''
  #       resp_data    = ''
  #     else
  #       resp_data    = ''
  #       resp_status  = 0
  #       resp_message = 'Errors'
  #       resp_errors  = 'student does not exist.'
  #     end
  #   rescue Exception => e
  #     resp_data    = ''
  #     resp_status  = 0
  #     resp_message = 'error'
  #     resp_errors  = e
  #   end
  #   common_api_response(resp_data, resp_status, resp_message, resp_errors)
  # end
  #
  #
  # def sign_up
  #   student = Student.new(student_params)
  #   if student.save!
  #     auth_token   = JsonWebToken.encode({ student_id: student.id })
  #     resp_data    = student_response(student, auth_token)
  #     resp_status  = 200
  #     resp_message = 'student created successfully'
  #     resp_errors  = ''
  #   else
  #     resp_data    = ''
  #     resp_status  = 400
  #     resp_message = 'Please enter valid email or password'
  #     resp_errors  = student.errors.full_messages
  #   end
  #   common_api_response(resp_data, resp_status, resp_message, resp_errors)
  # end
  #
  #
  # def update_student
  #   student                = Student.find_by_id(params[:student_id])
  #   auth_token   = JsonWebToken.encode({ student_id: student.id })
  #   student.first_name     = params[:first_name]
  #   student.last_name     = params[:last_name]
  #   image = Paperclip.io_adapters.for(params[:image])
  #   image.original_filename = "profile_picture.gif"
  #   student.avatar = image
  #
  #   if student.save!
  #     resp_data    = student_response(student, auth_token)
  #     resp_status  = 200
  #     resp_message = 'student is updated successfully'
  #     resp_errors  = ''
  #   else
  #     resp_data    = ''
  #     resp_status  = 400
  #     resp_message = 'student not found'
  #     resp_errors  = student.errors.full_messages
  #   end
  #   common_api_response(resp_data, resp_status, resp_message, resp_errors)
  # end
  def student_params
    # params.require(:student).permit(:email,:name,:password,:profile_image)
    params.require(:student).permit!
  end
  
  def patron_response(patron, auth_token)
    { auth_token: auth_token, patron: patron }.as_json
  end
  
  def books_response(books)
    { books_list: books }.as_json
  end
  
  def books_reserve(book)
    { reserved_book: book }.as_json
  end
  
  def book_details(book)
    { book_details: book }.as_json
  end
  
  def reserve_books_resp(books)
    books=books.as_json(
        include: {
            book: {
                only: [:id, :title, :sub_title, :statement_resource, :author, :sub_author, :book_type,
                       :account_no, :price, :entry_date, :ddc_no, :auth_mark, :section, :book_reference,
                       :book_publisher, :place, :book_year, :book_source, :book_edition, :book_volume,
                       :book_pages, :series, :language, :isbn, :binding, :cd_flopy, :status, :remarks,
                       :content, :notes, :subject, :keyword, :suggested_by, :discipline, :shipping_charges]
            }
        }
    
    )
  end
  def book_suggestion_params
    params.require(:book_suggestion).permit!
  end

end

