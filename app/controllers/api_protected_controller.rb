class ApiProtectedController < ApplicationController

  require 'json_web_token'
  attr_reader :current_user

  protected

  def json_builder(json, status, msg, *args)
    options = args.last.is_a?(Hash) ? args.pop : {}

    info               = ActiveSupport::OrderedHash.new
    info[:resp_status] = status
    info[:message]     = msg
    info[:errors]      = options[:errors]
    info[:paging_data] = options[:paging_data]

    unless (json.to_s == "")
      data = { :data => json }
      hash = info.merge(data)
    else
      unless options[:tag_name].blank?
        data = { :data => { options[:tag_name] => "" } }.to_hash
      else
        data = { :data => "" }.to_hash
      end
      hash = info.merge(data)
    end
    puts hash.to_json
    return hash.to_json
  end

  def common_api_response(resp_data, resp_status, resp_message, resp_errors, paging_data=nil)
    render json: json_builder(resp_data, resp_status, resp_message, errors: resp_errors, paging_data: paging_data)
  end

# Validates the token and user and sets the @current_user scope
  def authenticate_request!
    if !payload || !JsonWebToken.valid_payload(payload.first)
      return invalid_authentication
    end

    load_current_user!
    invalid_authentication unless @current_user
  end


# Returns 401 response. To handle malformed / invalid requests.
  def invalid_authentication
    render json: { error: 'Invalid Request' }, status: :unauthorized
  end

  private
# Deconstructs the Authorization header and decodes the JWT token.
  def payload
    auth_header = request.headers['Authorization']
    token       = auth_header.split(' ').last
    JsonWebToken.decode(token)
  rescue
    nil
  end

# Sets the @current_user with the user_id from payload
  def load_current_user!
    @current_user = User.find_by(id: payload[0]['user_id'])
  end

  def http_token
    @http_token ||= if request.headers['Authorization'].present?
                      request.headers['Authorization'].split(' ').last
                    end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end

end
