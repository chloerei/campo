class Admin::CategoriesController < Admin::ApplicationController
  before_filter :find_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.order(topics_count: :desc)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params

    if @category.save
      redirect_to admin_category_path(@category)
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :slug, :description)
  end

  def find_category
    @category = Category.find params[:id]
  end
end
