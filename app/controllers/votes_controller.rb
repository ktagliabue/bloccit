class VotesController < ApplicationController
  before_action :load_topic_and_post
  before_action :load_vote

  def upvote
   # authorize @vote
    @vote.value = 1
    @vote.save
    redirect_to topic_post_path(@topic, @post)
  end

  def downvote
   # authorize @vote
    @vote.value = -1
    @vote.save
    redirect_to topic_post_path(@topic, @post)
  end

  def load_topic_and_post
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
  end

  def load_vote
    @vote = Vote.find_or_initialize_by(user_id: current_user.id, post_id: @post.id)
  end
end
