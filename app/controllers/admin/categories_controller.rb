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
      flash[:success] = 'Category have been successfully created'
      redirect_to admin_category_path(@category)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = 'Category have been successfully updated'
      redirect_to admin_category_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = "Category #{@category.name} have been successfully destroy"
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :slug, :description)
  end

  def find_category
    @category = Category.find params[:id]
  end
end
