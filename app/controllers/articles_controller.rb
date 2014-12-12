class ArticlesController < ApplicationController

  def new
    @article = Article.new
    @titulo = "Nuevo Articulo"
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      render 'create'
    else
      @titulo = "Nuevo Articulo"
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all.order(created_at: :desc)
  end

  def edit
    @article = Article.find(params[:id])
    @titulo = "Editar Articulo"
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      render 'update'
    else
      @titulo = "Editar Articulo"
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

    def article_params
      params.require(:article).permit(:title, :content)
    end

end
