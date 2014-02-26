module Trashable
  extend ActiveSupport::Concern

  included do
    scope :trashed, -> { where(trashed: true) }
    scope :no_trashed, -> { where(trashed: false) }

    define_callbacks :trash, :restore
  end

  def trash
    run_callbacks(:trash) do
      update_attribute :trashed, true
    end
  end

  def restore
    run_callbacks(:restore) do
      update_attribute :trashed, false
    end
  end
end
