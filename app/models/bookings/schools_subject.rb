class Bookings::SchoolsSubject < ApplicationRecord
  belongs_to :bookings_school,
    class_name: "Bookings::School"

  belongs_to :bookings_subject,
    class_name: "Bookings::Subject"

  validates_associated :bookings_subject, :bookings_school

  validates :bookings_school_id,
    presence: true

  validates :bookings_subject_id,
    presence: true,
    uniqueness: { scope: :bookings_school_id }
end
