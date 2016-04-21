class PositionsController < ApplicationController

  include Savable

  before_action :authenticate_user!

  def index
    @positions = Position.all
  end

  private

  def strong_params
    params.require('position').permit(:name)
  end

end
