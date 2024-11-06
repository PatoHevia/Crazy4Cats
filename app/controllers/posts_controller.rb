class PostsController < ApplicationController
  before_action :find_post, only: [:show, :like, :dislike, :destroy]

  def index
    @posts = Post.includes(:comments, :reactions) # Carga las publicaciones con sus comentarios y reacciones
  end

  def show
    # @post ya está definido gracias a `find_post`
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params) # Asocia la publicación al usuario actual
    if @post.save
      redirect_to posts_path, notice: "Publicación creada con éxito."
    else
      render :new, alert: "Hubo un problema al crear la publicación."
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Publicación eliminada con éxito."
  end

  def like
    @reaction = @post.reactions.find_or_initialize_by(user: current_user)
    @reaction.update(reaction_type: "like")
  
    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Has dado 'me gusta' a la publicación." }
      format.js   # Esto renderizará like.js.erb si está presente
    end
  end
  
  def dislike
    @reaction = @post.reactions.find_or_initialize_by(user: current_user)
    @reaction.update(reaction_type: "dislike")
  
    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Has dado 'no me gusta' a la publicación." }
      format.js   # Esto renderizará dislike.js.erb si está presente
    end
  end  

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
