class ConversationsController < ApplicationController
  def index
    @conversations = current_user.conversations
  end

  def show
    @conversation = current_user.conversations.find(params[:id])
  end
end
