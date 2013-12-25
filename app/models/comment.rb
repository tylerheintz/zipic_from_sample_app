class Comment < ActiveRecord::Base
	belongs_to :micropost
	belongs_to :user
	validates :content, presence: true, length: {maximum: 250}
	validates :rating, presence: true, :numericality => { :greater_than_or_equal_to => 0}
	validates :user_id, presence: true
	validates :micropost_id, presence: true
end
