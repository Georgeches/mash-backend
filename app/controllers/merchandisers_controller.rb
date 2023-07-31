class MerchandisersController < ApplicationController
  before_action :authenticate_merchandiser, only: [:show]

  def create
    merchandiser = Merchandiser.create(merchandiser_params)
    if merchandiser.valid?
      session[:merchandiser_id] = merchandiser.id
      render json: { id: merchandiser.id, merchandisername: merchandiser.merchandisername, address: merchandiser.address, phone: merchandiser.phone }, status: :created
    else
      render json: { error: merchandiser.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    merchandiser = Merchandiser.find_by(id: session[:merchandiser_id])
    if merchandiser
      render json: merchandiser
    else
      render json: { error: "Not authorized" }, status: :unauthorized
    end
  end

  def reset
    @merchandisername = Merchandiser.find_by(merchandisername: params[:merchandisername].to_s)
    if @merchandisername.update(password: params[:password].to_s)
      render json: @merchandisername, status: :ok
    else
      render json: { error: 'Failed to update merchandisername.' }, status: :unprocessable_entity
    end
  end


  private


  def merchandiser_params
    params.permit(:name, :id_number, :phone_number, :vehicle_registration, :status, :profile_picture, :password_confirmation)
  end



  def authenticate_merchandiser
    unless logged_in?
      render json: { errors: "Unauthorized" }, status: :unauthorized
    end
  end

  def logged_in?
    session[:merchandiser_id].present?
  end

  def current_merchandiser
    Merchandiser.find_by(id: session[:merchandiser_id])
  end
end

