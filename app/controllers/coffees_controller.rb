class CoffeesController < ApplicationController
  before_action :set_coffee, only: [:show, :edit, :update, :destroy]

  # GET /coffees
  def index
    @coffees = Coffee.all
  end

  # GET /coffees/1
  def show
  end

  # GET /coffees/new
  def new
    @coffee = Coffee.new
  end

  # GET /coffees/1/edit
  def edit
  end

  # POST /coffees
  def create
    @coffee = Coffee.new(coffee_params)

    if @coffee.save
      redirect_to @coffee, notice: 'Coffee was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /coffees/1
  def update
    if @coffee.update(coffee_params)
      redirect_to @coffee, notice: 'Coffee was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /coffees/1
  def destroy
    @coffee.destroy
    redirect_to coffees_url, notice: 'Coffee was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coffee
      @coffee = Coffee.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def coffee_params
      params.fetch(:coffee, {})
    end
end
