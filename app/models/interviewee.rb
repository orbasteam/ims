class Interviewee < ActiveRecord::Base

  mount_uploader :resume, ResumeUploader

  validates :name, :gender, :number, :position_id, presence: true

  enum gender: { female: 0, male: 1 }
  enum status: [:pending, :no_response, :waiting, :refuse_interview, :candidate, :failed, :admit, :refuse, :black]

  belongs_to :position
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
