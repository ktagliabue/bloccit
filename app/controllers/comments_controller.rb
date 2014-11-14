class CommentsController < ApplicationController  
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.user = current_user
    @comment.save
    redirect_to topic_post_path(@post.topic.id, @post.id)
  end

  def destroy
     @post = @topic.posts.find(params[:post_id])
     @comment = @post.comments.find(params[:id])
 
     authorize @comment
     if @comment.destroy
       flash[:notice] = "Comment was removed."
       redirect_to [@post.topic, @post]
     else
       flash[:error] = "Comment couldn't be deleted. Try again."
       redirect_to [@post.topic, @post]
     end
   end
end
