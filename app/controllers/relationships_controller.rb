class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:relationship][:following_id])
    current_user.follow!(@user)
  end

  def destroy
    @user = Relationship.find(params[:id]).following
    current_user.unfollow!(@user)
  end

  private

  def use_before_action?
    true
  end
end
