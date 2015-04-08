class MessagesController < ApplicationController
	def index
		@message = Message.new
	end

	def create
		@message = Message.new(message_params)

    if(@message.valid?)
  		ContactMailer.new_message(@message).deliver_now
			redirect_to messages_path, notice: "Your message has been sent. Thanks!"
		else
			render 'index'
		end	
	end

		private

		def message_params
			params.require(:message).permit(:body, :name, :email)
		end
end
