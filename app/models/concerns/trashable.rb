module Trashable
  extend ActiveSupport::Concern

  included do
    default_scope { where(trashed: false) }
    scope :trashed, -> { unscope(where: :trashed).where(trashed: true) }
    scope :with_trashed, -> { unscope(where: :trashed) }

    define_model_callbacks :trash, :restore

    class << self
      alias_method_chain :belongs_to, :trashable
    end
  end

  module ClassMethods
    def belongs_to_with_trashable(name, scope = nil, options = {})
      belongs_to_without_trashable(name, scope, options)

      reflection = reflections[name]

      if reflection.options[:counter_cache]
        after_restore lambda { |record|
          record.belongs_to_counter_cache_after_create(reflection)
        }

        before_trash lambda { |record|
          record.belongs_to_counter_cache_before_destroy(reflection)
        }
      end

      return if method_defined? :belongs_to_counter_cache_before_destroy_with_trashable

      class_eval do
        def belongs_to_counter_cache_before_destroy_with_trashable(reflection)
          unless trashed?
            belongs_to_counter_cache_before_destroy_without_trashable(reflection)
          end
        end

        def belongs_to_counter_cache_after_update_with_trashable(reflection)
          unless trashed?
            belongs_to_counter_cache_after_update_without_trashable(reflection)
          end
        end
      end

      alias_method_chain :belongs_to_counter_cache_before_destroy, :trashable
      alias_method_chain :belongs_to_counter_cache_after_update, :trashable
    end
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
