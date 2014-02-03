module Trashable
  extend ActiveSupport::Concern

  included do
    scope :trashed, -> { where(trashed: true) }
    scope :untrashed, -> { where(trashed: false) }
  end

  def trash
    update_attribute :trashed, true
  end

  def restore
    update_attribute :trashed, false
  end
end
