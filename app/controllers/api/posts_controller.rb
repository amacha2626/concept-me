class Api::PostsController < ApplicationController
  def index
    @posts = Post.all
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
end
