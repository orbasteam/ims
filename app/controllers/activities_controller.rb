class ActivitiesController < ApplicationController

  include Savable

  def index
    @activities = Activity.where(interviewee_id: params[:interviewee_id])
                          .order(created_at: :desc)
  end

  private

  def edit_path(param)
    edit_interviewee_path(param.interviewee_id)
  end

  def strong_params
    params.require(:activity)
          .permit(:content)
          .merge(interviewee_id: params[:interviewee_id])
  end

end
