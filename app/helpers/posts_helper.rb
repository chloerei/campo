module PostsHelper
  def post_votes(posts, user)
    user.post_votes.where(post_id: posts.pluck(:id)).map { |post_vote|
      { post_id: post_vote.post_id, type: post_vote.type }
    }
  end
end
