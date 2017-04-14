class IntervieweesController < AdminController

  include Savable

  before_action :set_interviewees, only: [:index, :result, :calendar]
  before_action :set_interviewee_status, only: [:index, :result]

  def index
    params[:status] = params[:status].nil? ? 0 : params[:status]
    @interviewees = @interviewees.where(status: params[:status])
    set_activity_count
  end

  # search result
  def result

    if params[:keyword].blank?
      redirect_to action: :index
    end

    @interviewees = @interviewees.where('name like ? or number = ?', "%#{params[:keyword]}%", params[:keyword])
    set_activity_count
  end

  def calendar
    @interviewees = @interviewees.where(status: Interviewee.statuses[:waiting_interview])

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

  def set_empty_resource
    super
    build_relations
  end

  def after_save_failed(exception)
    build_relations
    super
  end

  def after_save_success(param)
    redirect_to interviewees_path status: param['status']
  end

  def set_interviewees
    @interviewees = Interviewee
                      .includes(:position)
                      .page(params[:page])
                      .order(created_at: :desc)
  end

  def set_interviewee_status
    @status = Interviewee.group(:status).count
  end

  def set_activity_count
    @activity_count = Activity.group_count(@interviewees)
  end

  def build_relations
    @interviewee.build_all_relations
  end

  def strong_params
    params.require(:interviewee)
      .permit(:finish_edit, :name, :number, :status, :position_id, :interview_at, :note,
              :name_en, :birthday, :native_place, :id_number, :gender, :blood_type, :communicate_address, :communicate_phone,
              :residence_address, :residence_phone, :email, :phone, :over_time, :marriage, :military, :relatives,
              :expertise, :hobby, :health, :genetic_disease, :genetic_disease_note, :nociceptive_disease,
              :nociceptive_disease_note, :other_disease, :other_disease_note, :chinese, :taiwanese, :hakka, :english,
              :japanese, :onboard_date, :wish_salary, :other_language_familiar, :other_language_unfamiliar,
              educations_attributes: [:id, :name, :department, :graduated, :school_type],
              experiences_attributes: [:id, :name, :title, :period, :seniority, :salary, :reason],
              families_attributes: [:id, :title, :name, :job],
              supervisors_attributes: [:id, :name, :department, :title, :phone, :contact_time]
      )
  end

end
