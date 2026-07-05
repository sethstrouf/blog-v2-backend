class CommentsController < ApplicationController
  include ApiKeyAuthenticatable

  prepend_before_action :authenticate_with_api_key!, only: %i[destroy]
  before_action :set_comment, only: %i[destroy]

  def create
    comment = Comment.new(comment_params)

    if comment.save
      render json: CommentSerializer.new(comment).serializable_hash, status: :created, location: comment
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy!
    head :no_content
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:commenter_name, :body, :post_id)
  end
end
