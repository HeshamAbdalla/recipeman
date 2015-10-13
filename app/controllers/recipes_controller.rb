class RecipesController < ApplicationController
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = User.find(2)

    if @recipe.save
      flash[:success] = "Your recipe was created successfuly"
      redirect_to recipes_path
    else
      render :new
    end
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
      if @recipe.update(recipe_params)
        flash[:success] = "Your recipe updated successfuly"
        redirect_to recipe_path(@recipe)
      else
        render :edit
      end
  end

  def destroy
  end

  def like
    @recipe = Recipe.find(params[:id])
    like = Like.create(like: params[:like], user: User.first, recipe: @recipe)
    if like.valid?
    flash[:success] = "You successfully liked this recipe"
    redirect_to :back
  else
    flash[:danger] = "You can only like or dislike a recipe once"
    redirect_to :back
  end
end

    private

      def recipe_params
        params.require(:recipe).permit(:name, :summary, :description, :picture)
      end
end
