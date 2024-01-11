class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show edit update destroy toggle_public add_food create_food]

  def index
    @recipes = current_user.recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def show
    @recipe = Recipe.includes(recipe_foods: :food).find(params[:id])
    @recipe_foods = @recipe.recipe_foods
    @user = current_user
    @food = Food.new if current_user == @recipe.user
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to recipes_url, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def destroy
    @recipe = Recipe.find(params[:id])

    if current_user == @recipe.user
      @recipe.destroy
      redirect_to recipes_url, notice: 'Recipe was successfully deleted.'
    else
      redirect_to recipes_url, alert: 'You are not authorized to delete this recipe.'
    end
  end

  def toggle_public
    @recipe = Recipe.find(params[:id])

    if current_user == @recipe.user
      @recipe.toggle!(:public)

      notice_message = if @recipe.public?
                         'Recipe is now public.'
                       else
                         'Recipe is now private.'
                       end
    else
      notice_message = 'You are not authorized to update this recipe.'
    end

    redirect_to recipe_path(@recipe), notice: notice_message
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public, :user_id)
  end

  def food_params
    params.require(:food).permit(:name, :quantity, :unit)
  end

  def shopping_list
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods
  end

  def add_ingredient
    @recipe = Recipe.find(params[:id])
    @food = Food.new
  end

  def public_recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
    render 'public_index'
  end
end
