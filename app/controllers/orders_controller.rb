class OrdersController < ApplicationController
    def index
        orders = Order.all
        render json: orders
    end
    
    def show
        order = Order.find_by(id: params[:id])
        if order
            render json: order
        else
            render json: { error: "order not found" }, status:404
        end
    end

    def create
        order =Order.create!(order_params)
        render json: order, status: :created
    end

    def update
        order = Order.find_by(id: params[:id])
        if order.update(order_params)
            render json: order
        else
            render json: order.errors, status: :unprocessable_entity
        end
    end

    def destroy
        order = Order.find_by(id: params[:id])
        order.destroy
        head :no_content
    end

    private
    def order_params
        params.permit(:customer_name, :products_ordered, :date, :merchandiser_id, :location)
    end
end
