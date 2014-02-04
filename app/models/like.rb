class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: true

  validates :likeable_type, inclusion: { in: %w(Topic Comment) }
  validates :user, :likeable, presence: true
end
