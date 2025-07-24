class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show edit update destroy dashboard]

  # GET /restaurants
  def index
    @restaurants = Restaurant.all
  end

  # GET /restaurants/:id
  def show; end

  # GET /restaurants/new
  def new
    @restaurant = Restaurant.new
  end

  # GET /restaurants/:id/edit
  def edit; end

  # POST /restaurants
  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to @restaurant, notice: "Restaurant was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /restaurants/:id
  def update
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: "Restaurant was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /restaurants/:id
  def destroy
    @restaurant.destroy!
    redirect_to restaurants_path, status: :see_other, notice: "Restaurant was successfully destroyed."
  end

  # GET /restaurants/:id/dashboard
  def dashboard
    @dishes = @restaurant.dishes.order(:dish_group, :name)
    @orders = @restaurant.orders
                         .includes(items: :dish)
                         .order(date: :desc)
                         .limit(params[:limit] || 20)

    @total_orders  = @restaurant.orders.count
    @total_revenue = @restaurant.orders.sum(:total)
    @best_sellers  = Item.joins(:dish, :order)
                         .where(orders: { restaurant_id: @restaurant.id })
                         .group("dishes.name")
                         .sum("items.quantity")
                         .sort_by { |_name, qty| -qty }
                         .first(3)
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :address, :phone, :logo)
  end
end
