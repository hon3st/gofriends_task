class Admin::MessagesController < Admin::BaseController
  before_action :find_message, only: [:edit, :update, :destroy]

  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to admin_messages_path, notice: t(".notice")
    else
      render :new
    end
  end

  def update
    if @message.update(message_params)
      redirect_to admin_messages_path, notice: t(".notice")
    else
      render :new
    end
  end

  def destroy
    if @message.destroy
      redirect_to admin_messages_path, notice: t(".notice")
    end
  end

  private

  def find_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:image, :description)
  end
end
