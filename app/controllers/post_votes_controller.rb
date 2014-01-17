class PostVotesController < ApplicationController
  before_filter :require_logined

  def update
    @post = Post.find params[:id]
    post_vote = @post.post_votes.find_or_initialize_by(user_id: current_user.id)

    case params[:type]
    when 'up'
      post_vote.update_attribute :up, true
    when 'down'
      post_vote.update_attribute :up, false
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @post = Post.find params[:id]
    @post.post_votes.find_or_initialize_by(user_id: current_user.id).try(:destroy)

    respond_to do |format|
      format.js { render :update }
    end
  end
end
