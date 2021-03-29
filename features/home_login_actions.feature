Feature: Do homepage features

  As a merchant
  So that I can see what my company is doing on svipd
  I want to login and see/edit my information

Background: On svipd homepage

  Given the following companies exist:
  | name                  | description | address                             | password                         | image_url | company_id  | username |
  | Columbia University   | test        | 600 w 116th st, new york, ny 10027  | 9dd4e461268c8034f5c8564e155c67a6 |   x       | 1           | dsfd     |
  | Columbia University2  | test        | 600 w 116th st, new york, ny 10027  | 9dd4e461268c8034f5c8564e155c67a6 |   x       | 2           | dsfdsfsd |

  Given the following products exist:
  | pid | name        | description | price     | stock_count | company_id  | image_url   |                                                                                                                     
  | 1   | Star Wars   | PG          | 5         |   5         | 1           | https://secure.img1-fg.wfcdn.com/im/23512985/resize-h800-w800%5Ecompr-r85/9718/97183556/VFAN+Jr.+Vintage+6%2522+Personal+Fan.jpg |
  | 2   | books       | Intelligent | 25        |   15        | 1           | https://secure.img1-fg.wfcdn.com/im/23512985/resize-h800-w800%5Ecompr-r85/9718/97183556/VFAN+Jr.+Vintage+6%2522+Personal+Fan.jpg |
  | 3   | xyz         | xyz         | 25        |   15        | 2           | https://secure.img1-fg.wfcdn.com/im/23512985/resize-h800-w800%5Ecompr-r85/9718/97183556/VFAN+Jr.+Vintage+6%2522+Personal+Fan.jpg |

  Given the following stories exist:
  | id  | company_id  | title                  | image            | description   |
  | 1   | 1           | BROOKS BROTHERS OFFER  |   "http://..."   | xyz           |

Scenario: View homepage
  When I go to the home page
  Then I should see "Save"
  And I should see "Search"
  And I should see "Social"
  And I should see "Trending"

Scenario: Go to login page
  When I go to the home page
  And I follow "Merchant"
  Then I should see "Login"
  Then I should see "password"


 Scenario: Login as a merchant
  When I go to the merchant_login page
   And  I fill in "username" with "dsfd"
   And  I fill in "password" with "x"
   And I press "Login"
   Then I should see "Products"

 Scenario: Failed login as a merchant
  When I go to the merchant_login page
   And  I fill in "username" with "invalid username"
   And I press "Login"
   Then I should not see "Products"

 Scenario: View stories as a merchant
  When I go to the merchant_login page
   And  I fill in "username" with "dsfd"
   And  I fill in "password" with "x"
   And I press "Login"
   And I follow "Stories"
   Then I should see "BROOKS"
   And I should not see "Intelligent"
   And I should not see "xyz"

 Scenario: View products as a merchant
  When I go to the merchant_login page
   And  I fill in "username" with "dsfd"
   And  I fill in "password" with "x"
   And I press "Login"
   Then I should see "Intelligent"
   And I should not see "BROOKS"
   And I should not see "xyz"