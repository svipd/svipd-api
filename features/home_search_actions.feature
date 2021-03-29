Feature: search for products

  As a customer
  So that I can buy a product
  I want to be able to search what's near me

Background: On svipd homepage

  Given the following companies exist:
  | name                  | description | address                             | image_url | company_id  | username | password  |
  | Columbia University   | test        | 600 w 116th st, new york, ny 10027  |   "x"     | 1           | dafdsfas | dsfsdfsd  |

  Given the following products exist:
  | pid | name          | description | price     | stock_count | company_id  |
  | 1   | Star Wars     | PG          | 5         |   5         | 1           |
  | 2   | books         | starter     | 25        |   15        | 1           |
  | 3   | xyz           | xyz         | 25        |   15        | 1           |
  | 4   | Shooting Star | gdsgds      | 5         |   5         | 1           |

Scenario: Search for products
  When I go to the home page
  And I fill in "search_search" with "star"
  And I press "button"
  Then I should see "Star Wars"
  And I should see "Shooting Star"
  And I should see "starter"
  And I should not see "xyz"