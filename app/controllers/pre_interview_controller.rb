class PreInterviewController < ApplicationController

  before_action :set_interviewee, except: [:complete]

  layout 'interviewee'

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  # 同意書
  def consent

  end

  def edit
    @interviewee.build_all_relations
  end

  def update

    begin

      @interviewee.update! interviewee_params.merge(finish_edit: true)

      redirect_to url_for(action: :complete)

    rescue Exception => e
      flash.now[:alert] = e.message
      @interviewee.build_all_relations
      render :edit
    end

  end

  def complete
    
  end

  private

  def set_interviewee
    @interviewee = Interviewee.find_by! token: params[:token], finish_edit: false
  end

  def interviewee_params
    params.require(:interviewee)
      .permit(:name_en, :birthday, :native_place, :id_number, :blood_type, :communicate_address, :communicate_phone,
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

  def handle_record_not_found
    raise ActionController::RoutingError.new('已填寫完畢，或找不到資料')
  end

end
