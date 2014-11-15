class CommentsController < ApplicationController  
  respond_to :html, :js

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post = @post
    @comment.user = current_user
    @comment.save
    redirect_to topic_post_path(@post.topic.id, @post.id)
  end

  def destroy
     # @post = @topic.posts.find(params[:post_id])
     @comment = Comment.find(params[:id])
 
     #authorize @comment
     if @comment.destroy
       flash[:notice] = "Comment was removed."
     else
       flash[:error] = "Comment couldn't be deleted. Try again."
     end
     respond_with(@comment) do |format|
       format.html { redirect_to [@post.topic, @post] }
     end
   end
end
