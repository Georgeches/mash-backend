class MerchandisersController < ApplicationController
  before_action :authenticate_merchandiser, only: [:show]
  skip_before_action :verify_authenticity_token, only: :create

  def index
    merchandisers = Merchandiser.all
    render json: merchandisers
  end

  def create
    merchandiser = Merchandiser.create(merchandiser_params)
    if merchandiser.valid?
      session[:merchandiser_id] = merchandiser.id
      render json: {  id_number:merchandiser.id_number,
        name: merchandiser.name,
        phone_number:merchandiser.phone_number,
        email:merchandiser.email , 
        vehicle_registration: merchandiser.vehicle_registration,
        profile_picture:merchandiser.profile_picture,
         status: merchandiser.status }, status: :created
  
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
    params.permit(:name, :id_number, :phone_number, :vehicle_registration, :status, :profile_picture, :password_confirmation,:password)
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

