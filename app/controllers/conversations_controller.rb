class ConversationsController < ApplicationController
  def index
    @conversations = current_user.conversations.order(created_at: :desc).limit(5)
  end

  def show
    @conversation = current_user.conversations.find(params[:id])
  end

  def create
    question = params[:question].to_s.strip
    return redirect_to conversations_path, status: :see_other if question.blank?

    conversation = current_user.conversations.create!(title: question.truncate(60), site: current_site)
    conversation.ask(question)
    redirect_to conversation, status: :see_other
  end
end
