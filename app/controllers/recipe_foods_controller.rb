class RecipeFoodsController < ApplicationController
  before_action :set_food_recipe, except: %i[edit destroy]
  def new
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)

    if @recipe_food.save
      flash[:notice] = 'Recipe food created successfully'
      redirect_to recipe_path(@recipe.id)

    else
      render 'new'
    end
  end

  def edit
    @recipe_food = RecipeFood.find(params[:recipe_id])
    @recipe = @recipe_food.recipe

    if @recipe_food
      # The record was found, proceed with rendering the edit view
    else
      flash[:alert] = 'Recipe food not found'
      redirect_to recipe_path(@recipe.id)
    end
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(update_food_params)
      redirect_to recipe_path(@recipe_food.recipe_id), notice: 'The recipe food was successfully updated.'
    else
      flash[:alert] = 'Failed to update recipe food'
      redirect_back_or_to root_path
    end
  end

  def destroy
    puts 'youu'
    @recipe_food = RecipeFood.find(params[:recipe_id])
    @recipe = @recipe_food.recipe

    if @recipe_food.destroy
      flash[:success] = 'Recipe_food deleted successfully'
    else
      flash[:error] = 'Error: Recipe_food could not be deleted'
    end

    redirect_to recipe_path(params[:recipe_id])
  end

  private

  def set_food_recipe
    @available_foods = Food.all
    @recipe = Recipe.find(params[:recipe_id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id, :recipe_id)
  end

  def update_food_params
    params.require(:recipe_food).permit(:quantity)
  end
end
