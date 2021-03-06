Feature: Creating new placement dates
    So I can add placement dates
    As a school administrator
    I want to be able to specify and create dates

    Background:
        Given I am logged in as a DfE user

    Scenario: Page title
        Given I am on the 'new placement date' page
        Then the page title should be 'Create a placement date'

  Scenario: Breadcrumbs
    Given I am on the 'new placement date' page
    Then I should see the following breadcrumbs:
        | Text                    | Link                     |
        | Some school             | /schools                 |
        | Placement dates         | /schools/placement_dates |
        | Create a placement date | None                     |

    Scenario: Placement date form
        Given I am on the 'new placement date' page
        Then I should see a form with the following fields:
            | Label                       | Type   |
            | Enter a start date          | date   |
            | How many days will it last? | number |

    Scenario: Filling in and submitting the form
        Given I am on the 'new placement date' page
        And I fill in the form with a future date and duration of 3
        When I submit the form
        Then I should be on the 'placement dates' page
        And my newly-created placement date should be listed
