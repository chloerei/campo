class Admin::AttachmentsController < Admin::ApplicationController
  def index
    @attachments = Attachment.includes(:user).order(id: :desc).page(params[:page])
  end

  def destroy
    @attachment = Attachment.find params[:id]
    @attachment.destroy
  end
end
