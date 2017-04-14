class PositionsController < AdminController

  include Savable

  def index
    @positions = Position.all
  end

  private

  def strong_params
    params.require('position').permit(:name)
  end

end
