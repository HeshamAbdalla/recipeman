class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :show, :update, :like]
  before_action :require_user, except: [:show, :index, :like]
  before_action :require_user_like, only: [:like]
  before_action :require_same_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
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
  end

  def show
  end

  def update
      if @recipe.update(recipe_params)
        flash[:success] = "Your recipe updated successfuly"
        redirect_to recipe_path(@recipe)
      else
        render :edit
      end
  end

  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe Deleted"
    redirect_to recipes_path
  end

  def like
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
        params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids: [], ingredient_ids: [])
      end

      def set_recipe
        @recipe = Recipe.find(params[:id])
      end

      def require_same_user
        if current_user != @recipe.user && !current_user.admin?
          flash[:danger] = "You cant edit other users profile"
          redirect_to root_path
        end
      end

    def require_user_like
      if !logged_in?
        flash[:danger] = "You must be logged in to like this recipe"
        redirect_to :back
      end
    end

  def admin_user
    redirect_to recipes_path unless current_user.admin?
  end
end
