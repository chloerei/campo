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

  private

  def find_category
    @category = Category.find params[:id]
  end
end
