class PostVotesController < ApplicationController
  before_filter :require_logined, :find_post, :reject_self_vote

  def update
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
    @post.post_votes.find_or_initialize_by(user_id: current_user.id).try(:destroy)

    respond_to do |format|
      format.js { render :update }
    end
  end

  private

  def find_post
    @post = Post.find params[:id]
  end

  def reject_self_vote
    if @post.user == current_user
      respond_to do |format|
        format.js { render :reject_self_vote }
      end
    end
  end
end
