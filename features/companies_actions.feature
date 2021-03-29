Feature: search for movies by director

  As a merchant
  So that I can sell more items
  I want to list my products for sale

  Background: products and companies in database

    Given the following companies exist:
      | name        | description | address                             | image_url | company_id  | username | password
      | Test Co     | test        | 600 w 116th st, new york, ny 10027  |   "x"     | 1           | asdf     | asdfas

  Scenario: View companies
    When I go to the companies page
    Then I should see "Test Co"

  Scenario: View a company
    When I go to the companies page
    And I follow "Click Here"
    Then I should see "Details"

  Scenario: Edit a company
    When I go to the companies page
    And I follow "Click Here"
    And I follow "Edit"
    And I fill in "company_name" with "Test Company"
    And I press "Update Company"
    Then I should see "Test Company"

  Scenario: Edit a company
    When I go to the companies page
    And I follow "Click Here"
    And I follow "Edit"
    And I fill in "company_name" with "Test Company"
    And I press "Update Company"
    Then I should see "Test Company"

  Scenario: Delete a company
    When I go to the companies page
    And I follow "Click Here"
    And I follow "Delete This Company"
    Then I should not see "Test"

    # Add company covered as part of login

