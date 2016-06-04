class IntervieweesController < ApplicationController

  include Savable

  before_action :authenticate_user!
  before_action :set_interviewees, only: [:index, :result, :calendar]
  before_action :set_interviewee_status, only: [:index, :result]

  def index
    params[:status] = params[:status].nil? ? 0 : params[:status]
    @interviewees = @interviewees.where(status: params[:status])
  end

  def result

    if params[:keyword].blank?
      redirect_to action: :index
    end

    @interviewees = @interviewees.where('name like ? or number = ?', "%#{params[:keyword]}%", params[:keyword])
  end

  def calendar
    @interviewees = @interviewees.where(status: Interviewee.statuses[:waiting])

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

  def set_interviewees
    @interviewees = Interviewee
                      .includes(:position, :interviewer)
                      .page(params[:page])
                      .order(created_at: :desc)
  end

  def set_interviewee_status
    @status = Interviewee.group(:status).count
    @activity_count = Activity.group_count(@interviewees)
  end

  def strong_params
    params.require(:interviewee)
          .permit(:name, :name_en, :gender, :number, :status,
                  :email, :phone, :position_id, :spot,
                  :skill, :interview_at, :note, :result, :resume, :interviewer_id)
  end

end
