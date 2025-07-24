class DishesController < ApplicationController
  before_action :set_restaurant
  before_action :set_dish, only: %i[show edit update destroy]

  def index
    @dishes = @restaurant.dishes
  end

  def show; end

  def new
    @dish = @restaurant.dishes.new
  end

  def edit; end

  def create
    Rails.logger.debug "⭐ PARAMS in CREATE: #{params[:dish].inspect}"
    @dish = @restaurant.dishes.new(dish_params)
    if @dish.save
      redirect_to [ @restaurant, @dish ], notice: "Dish created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    Rails.logger.debug "⭐ PARAMS in UPDATE: #{params[:dish].inspect}"
    if @dish.update(dish_params)
      redirect_to [ @restaurant, @dish ], notice: "Dish updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @dish.destroy!
    redirect_to restaurant_dishes_path(@restaurant), status: :see_other, notice: "Dish deleted."
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

  def set_dish
    @dish = @restaurant.dishes.find(params[:id])
  end

  def dish_params
    params.require(:dish).permit(
      :name, :description, :price,
      :dish_group, :restaurant_id,
      :photo
    )
  end
end
