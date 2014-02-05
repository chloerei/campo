module Subscribable
  extend ActiveSupport::Concern

  included do
    has_many :subscriptions, as: 'subscribable', dependent: :delete_all
    has_many :subscribed_users, -> { where(subscriptions: { status: Subscription.statuses['subscribed'] }) }, through: :subscriptions, source: :user
    has_many :ignored_users, -> { where(subscriptions: { status: Subscription.statuses['ignored'] }) }, through: :subscriptions, source: :user
  end

  def subscribe_by(user)
    subscriptions.find_or_initialize_by(user: user).subscribed!
  end

  def subscribed_by?(user)
    subscriptions.subscribed.where(user: user).exists?
  end

  def ignore_by(user)
    subscriptions.find_or_initialize_by(user: user).ignored!
  end

  def ignored_by?(user)
    subscriptions.ignored.where(user: user).exists?
  end
end
