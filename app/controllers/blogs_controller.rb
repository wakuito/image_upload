class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    @blog.image.retrieve_from_cache! params[:cache][:image]
    if params[:back]
      render :new
    else
      if @blog.save
        # ブログが保存された後に画像を移動し、ブログのレコードに保存する
        @blog.image = params[:blog][:image]
        BlogMailer.creation_confirmation(@blog).deliver_now
        redirect_to blogs_path, notice: "ブログを作成しました！"
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
    ActiveStorage::Current.url_options = Rails.application.config.action_mailer.default_url_options
    render :new if @blog.invalid?
  end


  private

  def blog_params
    params.require(:blog).permit(:title, :content, :image, :image_cache)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end
end