Feature: Background checks
    So I can prove to the school I'm trustworthy
    As a potential candidate
    I want to inform the school of my DBS check status

    Scenario: Page contents
        Given I am on the 'background checks' page for my school of choice
        Then I should see a paragraph informing me that some schools require a DBS check

    Scenario: Form contents
        Given I am on the 'background checks' page for my school of choice
        And I should see radio buttons for 'Do you have a DBS certificate?' with the following options:
            | Yes |
            | No  |
        And there should be some text continaing a link to the DBS website

    Scenario: Filling in and submitting the form
        Given I am on the 'background checks' page for my school of choice
        And I choose 'Yes' from the 'Do you have a DBS certificate?' radio buttons
        # We need to have filled in the whole wizard to progress, revisit
        #When I submit the form
        #Then I should be on the 'Check your answers' page
