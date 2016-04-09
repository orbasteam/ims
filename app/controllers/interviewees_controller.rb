class IntervieweesController < ApplicationController

  include Savable

  def index
    params[:status] = params[:status].nil? ? 0 : params[:status]
    @interviewees = Interviewee.includes(:position)
                        .page(params[:page])
                        .where!(status: params[:status])
                        .order(created_at: :desc)

    @status = Interviewee.group(:status).count
  end

  private

  def strong_params
    params.require('interviewee')
          .permit(:name, :name_en, :gender, :number, :status,
                  :email, :phone, :position_id, :spot,
                  :skill, :interview_at, :note, :result)
  end

end
