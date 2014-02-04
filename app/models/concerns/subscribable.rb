module Subscribable
  extend ActiveSupport::Concern

  included do
    has_many :subscriptions, as: 'subscribable', dependent: :delete_all
  end
end
