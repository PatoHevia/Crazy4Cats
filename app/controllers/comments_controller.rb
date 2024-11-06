class CommentsController < ApplicationController
  before_action :find_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id unless @comment.anonymous? # Solo asigna user_id si no es anónimo

    if @comment.save
      redirect_to @post, notice: "Comentario agregado exitosamente."
    else
      redirect_to @post, alert: "Hubo un problema al agregar tu comentario."
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :anonymous)
  end
end
