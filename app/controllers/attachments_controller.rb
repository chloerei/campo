class AttachmentsController < ApplicationController
  before_filter :login_required

  def create
    @attachment = current_user.attachments.create params.require(:attachment).permit(:file)

    render json: { url: @attachment.file.url }
  end
end
