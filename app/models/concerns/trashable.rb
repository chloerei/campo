module Trashable
  extend ActiveSupport::Concern

  included do
    scope :trashed, -> { where.not(trashed_at: nil) }
    scope :no_trashed, -> { where(trashed_at: nil) }
  end

  def trash
    update_attribute :trashed_at, current_time_from_proper_timezone
  end

  def restore
    update_attribute :trashed_at, nil
  end

  def trashed?
    trashed_at.present?
  end
end
