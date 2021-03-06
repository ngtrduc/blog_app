class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notis, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :title, presence: :true
  validates :user_id, presence: :true
  validates :content, presence: true, length: { maximum: 140 }
end
