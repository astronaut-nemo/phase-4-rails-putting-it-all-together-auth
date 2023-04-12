class RecipesController < ApplicationController
    before_action :authorize

    # GET /recipes
    def index
        recipes = Recipe.all
        render json: recipes, include: :user, status: :ok
    end

    # POST /recipes
    def create
        user = User.find_by(id: session[:user_id])
        recipe = user.recipes.create!(recipe_params)
        render json: recipe, include: :user, status: :created
    end

    private
    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
