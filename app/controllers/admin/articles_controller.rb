class Admin::ArticlesController < Admin::BaseController
  before_action :set_article, only: %i[edit update destroy]

  def index
    @articles = Article.includes(:category).order(created_at: :desc)
  end

  def new
    @article = Article.new(read_time: 5)
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to admin_articles_path, notice: "Совет «#{@article.title}» опубликован"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to admin_articles_path, notice: "Совет «#{@article.title}» сохранён"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to admin_articles_path, notice: "Совет удалён"
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :lead, :body, :category_id, :image, :read_time)
  end
end
