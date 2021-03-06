class NotifyEmail::CandidateRequestRejection < Notify
  attr_accessor :school_name, :candidate_name, :rejection_reasons, :school_experience_admin, :teaching_line_telephone_number

  def initialize(to:, school_name:, candidate_name:, rejection_reasons:, school_experience_admin:, teaching_line_telephone_number:)
    self.school_name                    = school_name
    self.candidate_name                 = candidate_name
    self.rejection_reasons              = rejection_reasons
    self.school_experience_admin        = school_experience_admin
    self.teaching_line_telephone_number = teaching_line_telephone_number
    super(to: to)
  end

private

  def template_id
    '577100df-1dae-405e-8500-947b85edf76e'
  end

  def personalisation
    {
      school_name: school_name,
      candidate_name: candidate_name,
      rejection_reasons: rejection_reasons,
      school_experience_admin: school_experience_admin,
      teaching_line_telephone_number: teaching_line_telephone_number
    }
  end
end
