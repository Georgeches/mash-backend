class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    merchandiser = Merchandiser.find_by(id_number: params[:id_number])
    if merchandiser && merchandiser.authenticate(params[:password])
      session[:merchandiser_id] = merchandiser.id
      render json: merchandiser, status: :created
    else
      logger.error("Failed login attempt for id_number: #{params[:id_number]}")
      render json: { error: 'Invalid id_number or password' }, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:merchandiser_id)
    render json: { message: 'Successfully logged out' }
  end
end
