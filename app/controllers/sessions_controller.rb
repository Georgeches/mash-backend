# # class SessionsController < ApplicationController
# #   skip_before_action :verify_authenticity_token, only: :create

# #   def create
# #     merchandiser = Merchandiser.find_by(id_number: params[:id_number])
# #     if merchandiser && merchandiser.authenticate(params[:password])
# #       session[:merchandiser_id] = merchandiser.id
# #       render json: merchandiser, status: :created
# #     else
# #       logger.error("Failed login attempt for id_number: #{params[:id_number]}")
# #       logger.error("Failed login attempt for password: #{params[:password]}")
# #       render json: { error: 'Invalid id_number or password' }, status: :unprocessable_entity
# #     end
# #   end

# #   def destroy
# #     session.delete(:merchandiser_id)
# #     render json: { message: 'Successfully logged out' }
# #   end
# # end
class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    admin = Admin.find_by(id_number: params[:id_number])

    if admin && admin.authenticate(params[:password])
      if admin.user_type == "admin"
        render json: { user_type: "admin", user_id: admin.id }, status: :created
      else
        render json: { error: "Invalid id_number or password." }, status: :unprocessable_entity
      end
    else
      merchandiser = Merchandiser.find_by(id_number: params[:id_number])

      if merchandiser && merchandiser.authenticate(params[:password])
        render json: { user_type: "merchant", user_id: merchandiser.id, merchandiser: merchandiser }, status: :created
      else
        render json: { error: "Invalid id_number or password." }, status: :unprocessable_entity
      end
    end
  end
end



