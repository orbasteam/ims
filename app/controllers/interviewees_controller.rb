class IntervieweesController < ApplicationController

  include Savable

  before_action :authenticate_user!

  def index
    params[:status] = params[:status].nil? ? 0 : params[:status]
    @interviewees = Interviewee.includes(:position, :interviewer)
                        .page(params[:page])
                        .where!(status: params[:status])
                        .order(created_at: :desc)

    @status = Interviewee.group(:status).count
  end

  def result

    if params[:keyword].blank?
      redirect_to action: :index
    end

    @interviewees = Interviewee.includes(:position)
                        .page(params[:page])
                        .where('name like ? or number = ?', "%#{params[:keyword]}%", params[:keyword])
  end

  def calendar
    @interviewees = Interviewee.includes(:position)
                        .where!(status: Interviewee.statuses[:waiting])
                        .order(created_at: :asc)

    result = []
    @interviewees.each do |interviewee|

      if interviewee.interview_at.present?
        time = interviewee.interview_at
        obj = {
            event: {
                id: interviewee.id,
                name: "#{interviewee.name} (#{interviewee.position.name})",
                startdate: time.to_s(:date_only),
                enddate: '',
                starttime: time.strftime("%H:%M"),
                endtime: (time + 2.hours).strftime("%H:%M"),
                color: '#e94b35',
                url: result_interviewees_path(keyword: interviewee.number)
            }
        }

        result.push obj
      end

    end

    respond_to do |format|
      format.xml {
        render xml: result
      }
    end

  end

  private

  def strong_params
    params.require(:interviewee)
          .permit(:name, :name_en, :gender, :number, :status,
                  :email, :phone, :position_id, :spot,
                  :skill, :interview_at, :note, :result, :resume)
          .merge(interviewer_id: current_user.id)
  end

end
