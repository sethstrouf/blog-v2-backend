class Comment < ApplicationRecord
  belongs_to :post

  validates :body, presence: true
  validates :commenter_name, length: { maximum: 100 }, allow_blank: true
end
