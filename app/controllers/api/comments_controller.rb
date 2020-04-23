class Api::CommentsController < ApplicationController
  protect_from_forgery :except => [:create, :destroy]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      Notification.create(visitor_id: params[:visitor_id], visited_id: params[:visited_id], post_id: params[:post_id], comment_id: @comment.id, action: 'comment')
      head :no_content
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end

  private

  def comment_params
    params.fetch(:comment, {}).permit(:content, :user_id, :post_id)
  end
end
