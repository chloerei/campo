module Trashable
  extend ActiveSupport::Concern

  included do
    scope :trashed, -> { where.not(trashed_at: nil) }
    scope :no_trashed, -> { where(trashed_at: nil) }

    define_callbacks :trash, :restore
  end

  def trash
    run_callbacks(:trash) do
      update_attribute :trashed_at, current_time_from_proper_timezone
    end
  end

  def restore
    run_callbacks(:restore) do
      update_attribute :trashed_at, nil
    end
  end

  def trashed?
    trashed_at.present?
  end
end
