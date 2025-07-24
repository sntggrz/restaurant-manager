class OrdersController < ApplicationController
  before_action :set_restaurant
  before_action :set_order, only: %i[show edit update destroy]

  def index
    @orders = @restaurant.orders.includes(items: :dish).order(date: :desc)
  end

  def show; end

  def new
    @order = @restaurant.orders.new(date: Time.current)
    @order.items.build
  end

  def edit
    @order.items.build if @order.items.empty?
  end

  def create
    @order = @restaurant.orders.new(order_params)
    @order.date ||= Time.current

    if @order.save
      redirect_to after_order_path, notice: "Order created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      redirect_to after_order_path, notice: "Order updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy!
    redirect_to dashboard_restaurant_path(@restaurant), status: :see_other, notice: "Order deleted."
  end

  include ReturnPath

  def after_order_path
    back_to_dashboard? ? dashboard_restaurant_path(@restaurant) : restaurant_orders_path(@restaurant)
  end

  private

  def after_order_path
    if params[:from] == "dashboard"
      dashboard_restaurant_path(@restaurant, tab: params[:tab] || :orders)
    else
      restaurant_orders_path(@restaurant)
    end
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def set_order
    @order = @restaurant.orders.includes(items: :dish).find(params[:id])
  end

  def order_params
    params.require(:order).permit(
      :date,
      items_attributes: [ :id, :dish_id, :quantity, :price, :_destroy ]
    )
  end
end
