class SessionsController < ApplicationController
  def create
    merchandiser = Merchandiser.find_by(id_number: params[:id_number])
    if merchandiser && merchandiser.authenticate(params[:password])
      session[:id_number] = merchandiser.id
      render json: merchandiser, status: :created
    else
      render json: { error: 'Unauthorized id_number and password' }, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:merchandiser_id)
    render json: { message: 'Successfully logged out' }
  end
end
