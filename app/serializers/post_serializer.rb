class PostSerializer
  include JSONAPI::Serializer

  attributes :title, :summary, :body, :created_at

  has_many :comments

  attribute :images do |post|
    urls = []

    if post.images.attached?
      post.images.each do |image|
        image = {
          filename: image.filename.to_s,
          url: Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
        }
        urls << image
      end
    end

    urls
  end
end
