class CommentsController < ApplicationController
  before_action :set_message
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @message.comments.build(comment_params)

    if @comment.save
      redirect_to @message, notice: 'Comment was successfully created.'
    else
      redirect_to @message, alert: 'Error adding comment.'
    end
  end

  def destroy
    @comment = @message.comments.find(params[:id])
    @comment.destroy
    redirect_to @message, notice: 'Comment was successfully deleted.'
  end

  def edit
    # @comment and @message are set by before_action
  end

  def update
    if @comment.update(comment_params)
      redirect_to @message, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_message
    @message = current_user.messages.find(params[:message_id])
  end

  def set_comment
    @comment = @message.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
