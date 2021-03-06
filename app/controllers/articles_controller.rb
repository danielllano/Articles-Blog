class ArticlesController < ApplicationController
  
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :publisher_user, only: [:new, :create]

  def new
    @article = current_user.articles.build
    @titulo = "Nuevo Articulo"
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      render 'create'
    else
      render 'new'
    end
  end

  def show
  end

  def index
    @articles = Article.all
    @ordered_comments = Comment.group(:article_id).order('count_all desc').count
  end

  def edit
    @titulo = "Editar Articulo"
  end

  def update
    if @article.update(article_params)
      render 'update'
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def correct_user
      @article = current_user.articles.find_by(id: params[:id])
      redirect_to articles_path, notice: "No autorizado para editar este Articulo" if @article.nil?
    end

    def publisher_user
      redirect_to articles_path, notice: "No autorizado para publicar" if current_user.publisher == false
    end

    def article_params
      params.require(:article).permit(:title, :content)
    end

end
