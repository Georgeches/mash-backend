class AdminsController < ApplicationController
    
    def index
        admins = Admin.all
        render json: admins
    end

    def show
        admin = Admin.find_by(id: params[:id])
        if admin
            render json: admin
        else
            render json: { error: "Admin not found" }, status:404
        end
    end

    def create
        admin = Admin.create!(admin_params)
        render json: admin, status: :created
    end

    def update
        admin = Admin.find_by(id: params[:id])
        if admin.update(admin_params)
            render json: admin
        else
            render json: admin.errors, status: :unprocessable_entity
        end
    end

    def destroy
        admin = Admin.find_by(id: params[:id])
        admin.destroy
        head :no_content
    end

    private
    def admin_params
        params.require(:admin).permit(:name, :password)
    end
end
