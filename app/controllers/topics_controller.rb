class TopicsController < ApplicationController
  def index
     @topics = Topic.visible_to(current_user).paginate(page: params[:page], per_page: 10)
     authorize @topics
  end

  def new
     @topic = Topic.new
     authorize @topics
  end

  def show
     @topic = Topic.find(params[:id])
     @posts = @topic.posts.paginate(page: params[:page], per_page: 10)
     authorize @topic
  end

  def edit
     @topic = Topic.find(params[:id])
     authorize @topics
  end
 
   def create
     @topic = Topic.new(params.require(:topic).permit(:name, :description, :public))
     authorize @topics

     if @topic.save
       redirect_to @topic, notice: "Topic was saved successfully."
     else
       flash[:error] = "Error creating topic. Please try again."
       render :new
     end
   end
 
   def update
     @topic = Topic.find(params[:id])
     authorize @topics

     if @topic.update_attributes(params.require(:topic).permit(:name, :description, :public))
       redirect_to @topic, notice: "Topic was saved successfully."
     else
       flash[:error] = "Error saving topic. Please try again"
       render :show
     end
   end

   def destroy
    @topic = Topic.find(params[:id])
    name = @topic.name

    authorize @topics
    if @topic.destroy
       flash[:notice] = "\"#{name}\" was deleted successfully."
       redirect_to topics_path
     else
       flash[:error] = "Error deleting topic. Please try again"
       render :show
     end
   end
end