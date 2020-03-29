class LikesController < ApplicationController
  protect_from_forgery :except => [:create, :destroy]

  def index
    @likes = Like.all
    render 'index', formats: 'json', handlers: 'jbuilder'
  end

  def create
    Like.create(post_id: params[:post_id], user_id: params[:user_id])
  end

  def destroy
    like = Like.find(params[:id])
    like.delete
  end
end
