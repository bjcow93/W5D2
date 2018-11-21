class PostsController < ApplicationController
  before_action :require_author!, only: :edit
  
  
  def new
    @post = Post.new
    @post.sub_id = params[:sub_id]
  end
  
  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id 
    
    if @post.save
      
      # params[:sub][:sub_ids].each do |id|
      #   PostSub.create!(sub_id: id, post_id: params[:id])
      # end
      
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new 
    end 
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    
    if @post && @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :edit 
    end 
  end
  
  def destroy
  end
  
  private
  def require_author!
    post = Post.find(params[:id])
    unless current_user.id == post.author_id
      flash[:errors] = ["You are not authorized to update this page!"]
      redirect_to post_url(post)
    end
  end
  
  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id, :sub_ids)
  end
  
end
