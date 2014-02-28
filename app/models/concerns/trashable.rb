module Trashable
  extend ActiveSupport::Concern

  included do
    default_scope { where(trashed: false) }
    scope :trashed, -> { unscope(where: :trashed).where(trashed: true) }
    scope :with_trashed, -> { unscope(where: :trashed) }

    define_model_callbacks :trash, :restore
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
