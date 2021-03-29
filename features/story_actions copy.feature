Feature: search for movies by director

  As a merchant
  So that I can advertise the most relevant information
  I want to login and be able to edit my company's stories

Background: On svipd homepage

  Given the following companies exist:
  | name                  | description | address                             | image_url | company_id  | username | password
  | Columbia University   | test        | 600 w 116th st, new york, ny 10027  |   "x"     | 1           | dssdfsdf | dsdfs
  | Columbia University2   | test       | 600 w 116th st, new york, ny 10027  |   "x"     | 2           | asda     | dsdfsdf

  Given the following products exist:
  | pid | name        | description | price     | stock_count | company_id  |
  | 1   | Star Wars   | PG          | 5         |   5         | 1           |
  | 2   | books       | Intelligent | 25        |   15        | 1           |
  | 3   | xyz         | xyz         | 25        |   15        | 2           |

  Given the following stories exist:
  | id  | company_id  | title                  | image            | description  |
  | 1   | 1           | BROOKS BROTHERS OFFER  |   "http://..."   | xyz           |

 Scenario: Add story as a merchant
  When I go to the merchant_login page
   And  I fill in "username" with "Columbia University"
   And I press "Login"
   And I follow "Stories"
   And I follow "Add new Story"
   And  I fill in "story_title" with "Test_story"
   And  I fill in "story_description" with "test"
   And  I fill in "story_url" with "h"
   And I press "Create"
   Then I should see "BROOKS"
   And I should see "Test_story"
   And I should not see "Intelligent"
   And I should not see "xyz" 
   
Scenario: Failing to add story as a merchant
  When I go to the merchant_login page
   And  I fill in "username" with "Columbia University"
   And I press "Login"
   And I follow "Stories"
   And I follow "Add new Story"
   And  I fill in "story_title" with "Test_story"
   And I press "Create"
   Then I should see "BROOKS"
   And I should not see "Test_story"
   And I should not see "Intelligent"
   And I should not see "xyz"

Scenario: Viewing my story
  When I go to the merchant_login page
   And  I fill in "username" with "Columbia University"
   And I press "Login"
   And I follow "Stories"
   And I follow "BROOKS BROTHERS OFFER"
   Then I should see "BROOKS BROTHERS OFFER"

   # Deleting story may be difficult with image... Idk how to do it right now