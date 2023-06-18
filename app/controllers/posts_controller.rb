class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy attach_images ]

  def index
    posts = Post.all.order(created_at: :desc)

    pagy, records = pagy(posts, items: params[:items] || Post.count)
    pagy_headers_merge(pagy)

    render json: PostSerializer.new(records, meta: pagy_metadata(pagy)).serializable_hash
  end

  def show
    render json: PostSerializer.new(@post, include: [:comments]).serializable_hash
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

  def attach_images
    params[:images].each do |image|
      @post.images.attach(image)
    end

    render json: PostSerializer.new(@post).serializable_hash
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
