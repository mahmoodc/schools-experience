Feature: Candidate landing page
    To give me an idea of service's purpose
    As a potential candidate
    I want to read an introduction to the service

    Scenario: Page heading
        Given I am on the 'landing' page
        Then the page's main header should be "Request school experience placements"

    Scenario: Leading paragraph
        Given I am on the 'landing' page
        Then the leading paragraph should provide me with a summary of the service

    Scenario: DBS information
        Given I am on the 'landing' page
        Then the page should include a paragraph on DBS checks with a link to the service

    Scenario: Location availability warning
        Given I am on the 'landing' page
        Then I should see a warning informing me that placements are only available in England

    Scenario: The start now button
        Given I am on the 'landing' page
        When I click the 'Start now' button
        Then I should be on the 'find a school' page

    Scenario: The 'teaching resources' column
        Given I am on the 'landing' page
        Then I should see a column on the right with the following useful links:
            | Get Into Teaching | https://getintoteaching.education.gov.uk/ |
        And the right column should have the subheading 'Teaching resources'

    Scenario: The 'Before you start' guide
        Given I am on the 'landing' page
        Then there should be a section titled 'Before you start'
        And it should contain some useful information about the process