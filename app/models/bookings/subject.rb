class Bookings::Subject < ApplicationRecord
  validates :name,
    presence: true,
    length: { minimum: 2, maximum: 64 },
    uniqueness: true

  has_many :bookings_schools_subjects,
    class_name: "Bookings::SchoolsSubject",
    inverse_of: :bookings_subject,
    foreign_key: :bookings_subject_id

  has_many :schools,
    class_name: "Bookings::School",
    through: :bookings_schools_subjects,
    source: :bookings_school
end
