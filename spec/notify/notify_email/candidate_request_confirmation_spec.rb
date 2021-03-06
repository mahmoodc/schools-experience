require 'rails_helper'

describe NotifyEmail::CandidateRequestConfirmation do
  it_should_behave_like "email template", "3860fb06-9af2-49c8-ac0b-007b9f360033",
    school_name: "Springfield Elementary School",
    candidate_address: "23 Railway Cuttings, East Cheam, CR3 0HD",
    candidate_dbs_check_document: "Yes",
    candidate_degree_stage: "Postgraduate",
    candidate_degree_subject: "Sociology",
    candidate_email_address: "tony.hancock@bbc.co.uk",
    candidate_name: "Tony Hancock",
    candidate_phone_number: "01234 456 678",
    candidate_teaching_stage: "I want to become a teacher",
    candidate_teaching_subject_first_choice: "Sociology",
    candidate_teaching_subject_second_choice: "Philosophy",
    placement_availability: "Mid lent",
    placement_outcome: "I enjoy teaching"

  it_should_behave_like "email template from application preview", false
end
