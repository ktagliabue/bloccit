class CommentsController < ApplicationController  
  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.user = current_user
    @comment.save
    redirect_to topic_post_path(@topic.id, @post.id)
  end
end
