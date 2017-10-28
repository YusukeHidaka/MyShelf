class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:relationship][:following_id])
    current_user.follow!(@user)
    puts "=================================="
    puts "=================================="
    puts "=================================="
    puts "=================================="
    puts "=================================="
    puts "relationshipsのcreate"
    puts "=================================="
    puts "=================================="
    puts "=================================="
    puts "=================================="
    puts "=================================="
  end

  def destroy
    @user = Relationship.find(params[:id]).following
    current_user.unfollow!(@user)
    puts "=================================="
    puts "=================================="
    puts "=================================="
    puts "=================================="
    puts "=================================="
    puts "relationshipsのdestroy"
    puts "=================================="
    puts "=================================="
    puts "=================================="
    puts "=================================="
    puts "=================================="
  end

  private

  def use_before_action?
    true
  end
end
