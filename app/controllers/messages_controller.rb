class MessagesController < ApplicationController
  def create
    conversation = current_user.conversations.find(params[:conversation_id])
    question = params[:question].to_s.strip
    conversation.ask(question) if question.present?
    redirect_to conversation, status: :see_other
  end
end
