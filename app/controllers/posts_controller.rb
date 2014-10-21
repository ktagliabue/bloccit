class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

 	def index
  	@posts = Post.all
    authorize @posts
  end

  def show
  end

  def new
  	@post = Post.new
    authorize @post
  end

  def create
     @post = current_user.posts.build(post_params)
     authorize @post
     if @post.save
       flash[:notice] = "Post was saved."
       redirect_to @post
     else
       flash[:error] = "There was an error saving the post. Please try again."
       render :new
     end
   end

  def edit
    authorize @post
  end

  def update #could I inherit from another method here? @adam
    authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to @post
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end



  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
