class UsersController < ApplicationController  
  def create
    @comments = Comment.all
    Comment.new(params.require(:comment).permit(:body)).save
    redirect_to comments_path
  end
end