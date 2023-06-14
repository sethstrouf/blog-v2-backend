class Post < ApplicationRecord
  has_many_attached :images

  validates :images, content_type: { in: %w[image/jpeg image/gif image/png],
                                     message: "must be a valid image format" },
                      size:        { less_than: 5.megabytes,
                                     message:   "should be less than 5MB" }

end
