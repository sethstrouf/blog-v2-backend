class Post < ApplicationRecord
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy

  has_many_attached :images, dependent: :destroy

  validates :images, content_type: { in: %w[image/jpeg image/gif image/png],
                                     message: "must be a valid image format" },
                      size:        { less_than: 5.megabytes,
                                     message:   "should be less than 5MB" }
end
