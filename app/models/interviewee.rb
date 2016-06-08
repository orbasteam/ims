class Interviewee < ActiveRecord::Base

  mount_uploader :resume, ResumeUploader

  validates :name, :gender, :number, :position_id, presence: true

  enum gender: { female: 0, male: 1 }
  enum status: {
      pending: 0,
      no_response: 1,
      send_email: 9,
      arrange_interview: 10,
      waiting_interview: 2,
      refuse_interview: 3,
      failed: 5,
      admit: 6,
      black: 7,
      abandon: 8
  }

  belongs_to :position
  belongs_to :interviewer, foreign_key: :interviewer_id, class_name: 'User'
  has_many :activities, -> { order(created_at: :desc) }

  before_create -> {
    self.status = :pending
  }

  after_update -> {

    self.activities.create({
        content: "[系統] 狀態修改為" + I18n.t("enums.interviewee.status.#{self.status}")
    })

  }, if: :status_changed?

end
