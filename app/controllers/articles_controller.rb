class ArticlesController < ApplicationController
  def index
    @categories = Category.order(:id)
    @category = @categories.find_by(id: params[:category_id])
    @articles = Article.includes(:category).search(params[:q]).order(:created_at)
    @articles = @articles.where(category: @category) if @category
  end

  def show
    @article = Article.find(params[:id])
  end
end
