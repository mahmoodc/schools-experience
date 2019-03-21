Feature: Schools search page sorting
    To help me find the ideal school
    As a potential candidate
    I want to be able to sort results by various criteria

    @javascript
    Scenario: Sorting by distance when searching by a specified location
        Given there there are schools with the following attributes:
            | Name              | Fee | Location   |
            | Manchester School | 30  | Manchester |
            | Rochdale School   | 10  | Rochdale   |
            | Burnley School    | 20  | Burnley    |
        And I have provided 'Bury' as my location
        When I select 'Distance' in the 'Sorted by' select box
        Then the results should be sorted by distance, nearest to furthest

    @javascript
    Scenario: Sorting by distance when searching by current location
        Given there there are schools with the following attributes:
            | Name              | Fee | Location   |
            | Manchester School | 30  | Manchester |
            | Rochdale School   | 10  | Rochdale   |
            | Burnley School    | 20  | Burnley    |
        And I have provided a point in 'Bury' as my location
        When I select 'Distance' in the 'Sorted by' select box
        Then the results should be sorted by distance, nearest to furthest

    @javascript
    Scenario: Sorting by name
        Given there there are schools with the following attributes:
            | Name                       | Fee | Location    |
            | Manton School              | 30  | Manton      |
            | Mansfield School           | 10  | Mansfield   |
            | Manningtree Primary School | 20  | Manningtree |
        And I have searched for 'Man' and am on the results page
        When I select 'Name' in the 'Sorted by' select box
        Then the results should be sorted by name, lowest to highest
