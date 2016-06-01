class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: { maximum: 140 }
end
