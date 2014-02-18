class Attachment < ActiveRecord::Base
  mount_uploader :file, FileUploader
end
