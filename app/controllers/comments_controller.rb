class CommentsController < ApplicationController
  include ApiKeyAuthenticatable

  prepend_before_action :authenticate_with_api_key!, only: %i[ destroy ]
  before_action :set_comment, only: %i[ destroy ]

  def index
    comments = Comment.all

    render json: CommentSerializer.new(comments).serializable_hash
  end

  def create
    comment = Comment.new(comment_params)

    if comment.save
      render json: CommentSerializer.new(comment).serializable_hash, status: :created, location: comment
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:commenter_name, :body, :post_id)
    end
end
