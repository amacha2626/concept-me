class Api::PostsController < ApplicationController
  protect_from_forgery :except => [:create]

  def index
    @posts = Post.with_attached_post_image
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def show
    @post = Post.with_attached_post_image.find(params[:id])
    @comments = @post.comments
    render 'show', formats: 'json', handlers: 'jbuilder'
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      @post.parse_base64(params[:post][:image])
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :user_id)
  end
end
