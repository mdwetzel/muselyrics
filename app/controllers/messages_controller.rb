class MessagesController < ApplicationController

  before_action :set_madness, only: [:index, :create]

	def index
		@message = Message.new
	end

	def create
		@message = Message.new(message_params)
    @message.ip = request.remote_ip
    @message.sent_at = Time.now

    if(@message.valid?)
  		ContactMailer.new_message(@message).deliver_now
			redirect_to messages_path, notice: "Your message has been sent. Thanks!"
		else
			render 'index'
		end	
	end

		private

    def set_madness
      @madness = Song.find_by(title: "Madness")
    end

		def message_params
			params.require(:message).permit(:body, :name, :email)
		end
end
