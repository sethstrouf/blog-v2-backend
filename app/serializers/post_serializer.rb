class PostSerializer
  include JSONAPI::Serializer

  attributes :title, :summary, :body, :updated_at
end
