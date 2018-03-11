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
    { auth_token: auth_token, patron: patron}.as_json
  end
end

