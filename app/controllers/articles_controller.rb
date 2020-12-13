class ArticlesController < ApplicationController
  #Below code is using DRY (not to repeat things)
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  def show  
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    #white listing only title and description
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to article_path(@article)
      #as a shortcut:
      #redirect_to @article
    else
      render 'new' 
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully. "
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private
  #only available to this controller

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

end