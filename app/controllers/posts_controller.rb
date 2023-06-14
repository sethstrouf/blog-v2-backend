class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]

  def index
    posts = Post.all.order(created_at: :desc)

    render json: PostSerializer.new(posts).serializable_hash
  end

  def show
    render json: PostSerializer.new(@post).serializable_hash
  end

  def create
    post = Post.new(post_params)

    if post.save
      render json: PostSerializer.new(post).serializable_hash, status: :created, location: post
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: PostSerializer.new(@post).serializable_hash
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :summary, :body)
    end
end
