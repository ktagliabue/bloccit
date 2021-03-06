class Topics::PostsController < ApplicationController
  def show
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    # @comments = Comment.where(post_id: @post.id)
    @comments = @post.comments
    @new_comment = Comment.new
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(params.require(:post).permit(:title, :body))
    @post.topic = @topic
    authorize @post

    if @post.save_with_upvote_for(current_user)
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post

    if @post.update_attributes(params.require(:post).permit(:title, :body))
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    title = @post.title
    authorize @post

    if @post.destroy
       flash[:notice] = "\"#{title}\" was deleted successfully."
       redirect_to @topic
     else
       flash[:error] = "Error deleting topic. Please try again"
       render :show
     end
  end
end