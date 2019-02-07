Feature: Check if my details are already held
    So I can pre-fill later stages of the wizard
    As a potential candidate
    I want to check if my details are already held by the DfE

    Scenario: Page contents
        Given I am on the 'Check if we already have your details' page
        Then the page's main header should be 'Check if we already have your details'
        And I should see a paragraph informing me I can speed up my placement request
        And the paragraph should contain a 'Get Into Teaching' link to 'https://getintoteaching.education.gov.uk'

    Scenario: Form contents
        Given I am on the 'Check if we already have your details' page
        Then I should see a form with the following fields:
            | Label         | Type  |
            | Full name     | text  |
            | Email address | email |

    Scenario: Submitting my data
        Given I am on the 'Check if we already have your details' page
        And I have entered the following details into the form:
            | Full name     | Philip Gilbert         |
            | Email address | phil.gilbert@gmail.com |
        When I submit the form
        Then I should be on the 'candidate address' page
