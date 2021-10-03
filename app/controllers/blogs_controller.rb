class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :new
    else
      if @blog.save
        PostMailer.post_mail(@blog).deliver
        redirect_to blogs_path, notice: "投稿しました！"
      else
        render :new
      end
    end
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "編集しました！"
    else
      render :edit
    end
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
  end

  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "削除しました" }
      format.json { head :no_content }
    end
  end

  private
  def set_blog
    @blog = Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:content, :image, :image_cache, :user_id)
  end
end
