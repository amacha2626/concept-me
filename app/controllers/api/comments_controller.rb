class Api::CommentsController < ApplicationController
  protect_from_forgery :except => [:create, :destroy]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      head :no_content
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.fetch(:comment, {}).permit(:content, :user_id, :post_id)
  end
end
