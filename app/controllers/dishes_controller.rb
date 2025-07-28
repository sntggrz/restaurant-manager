class DishesController < ApplicationController
  before_action :maybe_set_restaurant
  before_action :set_dish, only: %i[show edit update destroy]

  # GET /dishes or /restaurants/:restaurant_id/dishes
  def index
    @dishes = @restaurant ? @restaurant.dishes : Dish.all
  end

  # GET /dishes/:id or /restaurants/:restaurant_id/dishes/:id
  def show
  end

  # GET /dishes/new or /restaurants/:restaurant_id/dishes/new
  def new
    @dish = (@restaurant ? @restaurant.dishes : Dish).new
  end

  # GET /dishes/:id/edit or /restaurants/:restaurant_id/dishes/:id/edit
  def edit
  end

  # POST /dishes or /restaurants/:restaurant_id/dishes
  def create
    @dish = (@restaurant ? @restaurant.dishes : Dish).new(dish_params)
    if @dish.save
      redirect_to @dish, notice: "Dish created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dishes/:id or /restaurants/:restaurant_id/dishes/:id
  def update
    if @dish.update(dish_params)
      redirect_to @dish, notice: "Dish updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /dishes/:id or /restaurants/:restaurant_id/dishes/:id
  def destroy
    @dish.destroy
    flash[:notice] = "Dish deleted."
    redirect_to(
      @restaurant ? restaurant_dishes_path(@restaurant) : dishes_path
    )
  end

  private

  # If params[:restaurant_id] is present, load that restaurant.
  def maybe_set_restaurant
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
  end

  # Find either nested or top-level dish.
  def set_dish
    scope = @restaurant ? @restaurant.dishes : Dish
    @dish = scope.find(params[:id])
  end

  def dish_params
    params.require(:dish)
          .permit(:name, :description, :price, :dish_group, :photo, :restaurant_id)
  end
end
