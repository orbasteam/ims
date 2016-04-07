class IntervieweesController < ApplicationController

  include Savable

  def index
    @interviewees = Interviewee.includes(:position)
                        .order(created_at: :desc)
                        .page(params[:page])

    if params[:status]
      @interviewees.where!(status: params[:status])
    end

  end

  private

  def strong_params
    params.require('interviewee')
          .permit(:name, :name_en, :gender, :number, :status,
                  :email, :phone, :position_id, :spot,
                  :skill, :interview_at, :note, :result)
  end

end
