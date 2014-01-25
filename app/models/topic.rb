class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :posts
  has_one :main_post, -> { where post_number: 1 }, class_name: 'Post'

  accepts_nested_attributes_for :main_post

  def score
    # TODO
    0
  end

  def calculate_hot
    order = Math.log10([score.abs, 1].max)
    sign = if score > 0
             1
           elsif score < 0
             -1
           else
             0
           end
    order + sign * created_at.to_i / 45000
  end

  def calculate_hot!
    update_attribute :hot, calculate_hot
  end
end
