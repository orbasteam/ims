class ActivitiesController < AdminController

  include Savable

  def index
    @activities = Activity.where(interviewee_id: params[:interviewee_id])
                          .order(created_at: :desc)
  end

  private

  def after_save_success(param)
    redirect_to edit_interviewee_path(param.interviewee_id)
  end

  def after_save_failed(exception)
    flash[:alert] = exception.message
    redirect_to edit_interviewee_path(params[:interviewee_id])
  end

  def strong_params
    params.require(:activity)
          .permit(:content)
          .merge(interviewee_id: params[:interviewee_id])
  end

end
