module PostVotesHelper
  def post_voted_up?(post, user)
    post.post_votes.find_by(user_id: user.id).try(:up?)
  end

  def post_voted_down?(post, user)
    post.post_votes.find_by(user_id: user.id).try(:up?) == false
  end
end
