class Schools::OnBoarding::PhaseSubject < ApplicationRecord
  # TODO write specs
  belongs_to :schools_school_profile,
    class_name: 'Schools::SchoolProfile',
    foreign_key: :schools_school_profile_id

  belongs_to :phase,
    class_name: 'Bookings::Phase',
    foreign_key: :bookings_phase_id

  belongs_to :subject,
    class_name: 'Bookings::Subject',
    foreign_key: :bookings_subject_id

  validates :schools_school_profile, presence: true
  validates :subject, presence: true
  validates :phase, presence: true

  validates :schools_school_profile_id,
    uniqueness: { scope: [:bookings_subject_id, :bookings_phase_id] }

  scope :secondary, -> do
    joins(:phase).where(bookings_phases: { name: 'Secondary' })
  end
end
