class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }
  after_save :update_rank

  def update_rank
    self.post.update_rank
  end
end



# POST /topics/1/posts/5/upvote


# resources :topics do
#   resources :posts do
#     # /topics/:topic_id/posts/:post_id/...
#     # POST /topics/:topic_id/posts/:post_id/upvote  => VotesController#upvote
#     post upvote => 'votes#upvote'
#   end
# end
