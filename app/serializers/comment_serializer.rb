class CommentSerializer
  include JSONAPI::Serializer

  attributes :commenter_name, :body, :post_id, :created_at
end
