class MessagesController < ApplicationController
	before_action :require_login, only: [:index]
	def new
		@message = Message.new
		@available_recipient = current_user.friends.order(:name)
	end

	def create
		recipients = params[:message][:recipient_id] ? params[:message][:recipient_id].compact.reject {|item| item.empty? } : []
		unless recipients.any?
			redirect_to new_message_path, flash: {error: "You should choose your friend to send message."}
		else
			recipients.each do |recipient|
				message = Message.new(message_params)
				message.recipient_id = recipient
				unless message.save
					redirect_to new_message_path, flash: {error: "Oops! Something went wrong. "}
				end
			end
			redirect_to root_path , flash: {success: "Your message has been sent."}

      
  end
end

def get_sent_message
	@sent_messages = Message.where(sender_id: session[:user_id]).order("created_at desc") || []
	render 'send_message'
end

def index
	recipient_id = params[:recipient_id]
	 @messages = Message.where(recipient_id: current_user).order("created_at desc") || []
	@new_message_count  = @messages.to_a.count {|message| message.unread }
end

def show
	@message = Message.find params[:id]
	if @message.recipient_id != session[:user_id]
		redirect_to root_path, flash: {error: "Sorry! You only can view your messages."}
	else
		@message.unread = false
		@message.readtime = DateTime.current
		@message.save
	end
end

private

def message_params
	params.require(:message).permit(:content, :sender_id, :unread, {avatars: []})
end
end
