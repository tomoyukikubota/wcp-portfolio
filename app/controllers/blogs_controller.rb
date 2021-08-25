class BlogsController < ApplicationController

  before_action :current_user_blog, only: [:show, :edit, :update]

  def index
    # @blogs = Blog.where(user_id: current_user.id).order("start_time")
    # 日付の若い順
    @blogs = Blog.all.order("start_time")
  end

  def new
    @blog = Blog.new
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def create
    @blog = Blog.new(blog_params)
    # Blog.create(blog_params)
    # binding.pry
    @blog.save
    redirect_to blogs_path
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    @blog.update(blog_params)
    redirect_to blogs_path
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content, :start_time).merge(user_id: current_user.id)
  end

  def current_user_blog
    blog = Blog.find(params[:id])
    if blog.user != current_user
      redirect_to blogs_path
    end
  end
end
