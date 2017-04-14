class Interviewee < ActiveRecord::Base

  mount_uploader :resume, ResumeUploader

  has_many :educations
  has_many :experiences
  has_many :families
  has_many :supervisors

  accepts_nested_attributes_for :educations,  reject_if: -> (attributes) { attributes[:name].blank? }
  accepts_nested_attributes_for :experiences, reject_if: -> (attributes) { attributes[:name].blank? }
  accepts_nested_attributes_for :families,    reject_if: -> (attributes) { attributes[:name].blank? }
  accepts_nested_attributes_for :supervisors, reject_if: -> (attributes) { attributes[:name].blank? }

  validates :name, :gender, :number, :position_id, presence: true
  validates :id_number, format: { with: /\A[A-Z]\d{9}\z/, message: "格式不合" }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

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
  enum military: {
    military_yet: 1,
    military_finish: 2,
    military_no_need: 3
  }

  belongs_to :position
  has_many :activities, -> { order(created_at: :desc) }

  before_create -> {
    self.status = :pending
    self.token  = SecureRandom.hex(32)
  }

  after_update -> {

    self.activities.create({
        content: "[系統] 狀態修改為" + I18n.t("enums.interviewee.status.#{self.status}")
    })

  }, if: :status_changed?

  def build_all_relations
    self.educations.build  if self.educations.empty?
    self.experiences.build if self.experiences.empty?
    self.families.build    if self.families.empty?
    self.supervisors.build if self.supervisors.empty?
  end

end
