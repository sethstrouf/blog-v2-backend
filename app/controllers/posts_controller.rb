class PostsController < ApplicationController
  include ApiKeyAuthenticatable

  prepend_before_action :authenticate_with_api_key!, only: %i[create update destroy attach_images delete_image]
  before_action :set_post, only: %i[show update destroy attach_images delete_image]

  def index
    posts = Post.all.order(created_at: :desc)
    pagy, records = pagy(posts, items: params[:items] || Pagy::DEFAULT[:items])

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
      render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: PostSerializer.new(@post).serializable_hash
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    head :no_content
  end

  def attach_images
    return head :bad_request if params[:images].blank?

    params[:images].each { |image| @post.images.attach(image) }
    render json: PostSerializer.new(@post).serializable_hash
  end

  def delete_image
    @post.images.each do |image|
      blob_path = Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
      image.purge if params[:image_url] == blob_path
    end

    render json: PostSerializer.new(@post).serializable_hash
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :summary, :body)
  end
end
