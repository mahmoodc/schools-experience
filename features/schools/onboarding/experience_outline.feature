Feature: Experience Outline
  So candidates know what to expect
  As a school administrator
  I want to be able to outline what to expect from the experience

  Background: I have completed the wizard thus far
    Given I am logged in as a DfE user
    And the secondary school phase is availble
    And the college phase is availble
    And there are some subjects available
    And I have completed the following steps:
        | Step name                    | Extra                     |
        | Candidate Requirements       |                           |
        | Fees                         | choosing only Other costs |
        | Other costs                  |                           |
        | Phases                       |                           |
        | Subjects                     |                           |
        | Description                  |                           |
        | Candidate experience details |                           |

  Scenario: Breadcrumbs
    Given I am on the 'Experience Outline' page
    Then I should see the following breadcrumbs:
        | Text                                    | Link     |
        | Some school                             | /schools |
        | Outline experience and teacher training | None     |

  Scenario: Completing the step with error
    Given I am on the 'Experience Outline' page
    And I enter 'A really good one' into the 'What kind of school experience do you offer candidates?' text area
    And I choose 'Yes' from the 'Do you run your own teacher training or have any links to teacher training organisations and providers?' radio buttons
    When I submit the form
    Then I should see a validation error message

  Scenario: Completing the step
    Given I am on the 'Experience Outline' page
    And I enter 'A really good one' into the 'What kind of school experience do you offer candidates?' text area
    And I choose 'Yes' from the 'Do you run your own teacher training or have any links to teacher training organisations and providers?' radio buttons
    And I enter 'We run our own training' into the 'Provide details.' text area
    And I enter 'http://example.com' into the 'Enter a web address.' text area
    When I submit the form
    Then I should be on the 'Availability preference' page
