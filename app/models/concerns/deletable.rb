module Deletable
  extend ActiveSupport::Concern

  included do
    scope :visible, -> { where(deleted: false) }
  end

  def delete
    update_attribute :deleted, true
  end

  def restore
    update_attribute :deleted, false
  end
end
