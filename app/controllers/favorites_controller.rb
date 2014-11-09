class FavoritesController < ApplicationController
  def create
    @authorize
    @topic = Topic.find(params[:topic_id]) 
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.build(post: @post)

    if @favorite.save
      flash[:notice] = "This was favorited"
      redirect_to [@topic, @post]
    else
      flash[:notice] = "This wasn't favorited."
    end
  end

  def destroy
    @authorize
    @topic = Topic.find(params[:topic_id]) 
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites(params[:post_id]).first
    p @favorite
    # Find the current user's favorite with the ID in the params

    if @favorite.destroy
      flash[:notice] = "This is no longer favorited"
      redirect_to [@topic, @post]
    else
      flash[:notice] = "Something went wrong"
      redirect_to [@topic, @post]
    end
  end
end
