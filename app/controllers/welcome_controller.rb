class WelcomeController < ApplicationController
  def index
  end

  private

  def use_before_action?
    false
  end
end
