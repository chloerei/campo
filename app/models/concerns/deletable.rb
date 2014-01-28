module Deletable
  extend ActiveSupport::Concern

  def delete
    update_attribute :deleted, true
  end

  def restore
    update_attribute :deleted, false
  end
end
