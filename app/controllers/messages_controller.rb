class MessagesController < ApplicationController
  def index
    @messages = current_user.messages
  end

  def show
    @message = current_user.messages.find(params[:id])
  end

  def new
    @message = current_user.messages.new
  end

  def create
    @message = current_user.messages.build(message_params) # Sets the author to the current user
    if @message.save
      redirect_to @message, notice: 'Message was successfully created.'
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:title, :body)
  end
end
