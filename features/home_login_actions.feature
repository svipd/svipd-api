Feature: Do homepage features

  As a merchant
  So that I can see what my company is doing on svipd
  I want to login and see/edit my information

  Background: On svipd homepage

    Given the following companies exist:
      | name                 | description | address                            | password                         | image_url | company_id | username |
      | Columbia University  | test        | 600 w 116th st, new york, ny 10027 | 9dd4e461268c8034f5c8564e155c67a6 | x         | 1          | dsfd     |
      | Columbia University2 | test        | 600 w 116th st, new york, ny 10027 | 9dd4e461268c8034f5c8564e155c67a6 | x         | 2          | dsfdsfsd |

    Given the following users exist:
      | username | fname          | lname            | password                         |
      | user1    | a long String  | sanename         | 9dd4e461268c8034f5c8564e155c67a6 |
      | user2    | @nother $tr1ng | not_ soSaNe Name | 9dd4e461268c8034f5c8564e155c67a6 |

    Given the following products exist:
      | pid | name      | description | price | stock_count | company_id | image_url                                                                                                                        |
      | 1   | Star Wars | PG          | 5     | 5           | 1          | https://secure.img1-fg.wfcdn.com/im/23512985/resize-h800-w800%5Ecompr-r85/9718/97183556/VFAN+Jr.+Vintage+6%2522+Personal+Fan.jpg |
      | 2   | books     | Intelligent | 25    | 15          | 1          | https://secure.img1-fg.wfcdn.com/im/23512985/resize-h800-w800%5Ecompr-r85/9718/97183556/VFAN+Jr.+Vintage+6%2522+Personal+Fan.jpg |
      | 3   | xyz       | xyz         | 25    | 15          | 2          | https://secure.img1-fg.wfcdn.com/im/23512985/resize-h800-w800%5Ecompr-r85/9718/97183556/VFAN+Jr.+Vintage+6%2522+Personal+Fan.jpg |

    Given the following stories exist:
      | id | company_id | title                 | image        | description |
      | 1  | 1          | BROOKS BROTHERS OFFER | "http://..." | xyz         |

    Given the following posts exist:
      | id | user_id    | title                 | image        | message     |
      | 1  | 1          | I love this!          | "http://..." | xyz         |

  Scenario: View homepage
    When I go to the home page
    Then I should see "Save"
    And I should see "Search"
    And I should see "Social"
    And I should see "Trending"

  Scenario: Go to login page
    When I go to the home page
    And I follow "Login"
    Then I should see "Login"
    And I should see "password"
    And I should see "Are you a merchant?"

  Scenario: Login as a user
    When I go to the home page
    And I follow "Login"
    And  I fill in "username" with "user1"
    And  I fill in "password" with "x"
    And I press "Login"
    Then I should see "Logout"

  Scenario: Failed login as a user
    When I go to the home page
    And I follow "Login"
    And  I fill in "username" with "user1"
    And  I fill in "password" with "wrong_password"
    And I press "Login"
    Then I should not see "Logout"
    And I should see "Login"

  Scenario: Logout user
    When I go to the home page
    And I follow "Login"
    And  I fill in "username" with "user1"
    And  I fill in "password" with "x"
    And I press "Login"
    And I follow "Logout"
    Then I should see "Login"

  Scenario: User sign up fails because the username already exists
    When I go to the home page
    And I follow "Login"
    And I follow "Create Account"
    And  I fill in "user_fname" with "Saul"
    And  I fill in "user_lname" with "Goodman"
    And  I fill in "user_username" with "user1"
    And  I fill in "user_password" with "abcdeghi"
    And  I fill in "user_email" with "abcdeghi@gmail.com"
    And I press "Create Account"
    Then I should see "That username already exists. Please try a different one"

  Scenario: User sign up fails because the password is shorter than 8 characters
    When I go to the home page
    And I follow "Login"
    And I follow "Create Account"
    And  I fill in "user_fname" with "Saul"
    And  I fill in "user_lname" with "Goodman"
    And  I fill in "user_username" with "user3"
    And  I fill in "user_password" with "1234567"
    And  I fill in "user_email" with "abcdeghi@gmail.com"
    And I press "Create Account"
    Then I should see "Password must be at least 8 characters long"

  Scenario: Sign up a user
    When I go to the home page
    And I follow "Login"
    And I follow "Create Account"
    And  I fill in "user_fname" with "Saul"
    And  I fill in "user_lname" with "Goodman"
    And  I fill in "user_username" with "user3"
    And  I fill in "user_password" with "1234567ate"
    And  I fill in "user_email" with "abcdeghi@gmail.com"
    And I press "Create Account"
    Then I should see "Login"

  Scenario: Login as a merchant
    When I go to the home page
    And I follow "Login"
    And I follow "Are you a merchant?"
    And  I fill in "username" with "dsfd"
    And  I fill in "password" with "x"
    And I press "Login"
    Then I should see "Products"

  Scenario: Logged in merchant should see products directly if he opens login again
    When I go to the home page
    And I follow "Login"
    And I follow "Are you a merchant?"
    And  I fill in "username" with "dsfd"
    And  I fill in "password" with "x"
    And I press "Login"
    Then I should see "Products"
    And I go to the merchant login page
    Then I should see "Products"

  Scenario: Failed login as a merchant
    When I go to the home page
    And I follow "Login"
    And I follow "Are you a merchant?"
    And  I fill in "username" with "invalid username"
    And I press "Login"
    Then I should not see "Products"

  Scenario: Logout merchant
    When I go to the home page
    And I follow "Login"
    And I follow "Are you a merchant?"
    And  I fill in "username" with "dsfd"
    And  I fill in "password" with "x"
    And I press "Login"
    And I follow "Log Out"
    Then I should see "Merchant Login"

  Scenario: Merchant sign up fails because the username already exists
    When I go to the home page
    And I follow "Login"
    And I follow "Are you a merchant?"
    And I follow "Create Account"
    And  I fill in "company_name" with "The Goods Company"
    And  I fill in "company_description" with "A very goods company"
    And  I fill in "company_address" with "addressed all the goods"
    And  I fill in "company_email" with "goods@goodygoods.com"
    And  I fill in "company_image_url" with "notfound.com"
    And  I fill in "company_username" with "dsfd"
    And  I fill in "company_password" with "abcdeghi"
    And I press "Create Merchant Account"
    Then I should see "That username already exists. Please try a different one"

  Scenario: Merchant sign up fails because the password is shorter than 8 characters
    When I go to the home page
    And I follow "Login"
    And I follow "Are you a merchant?"
    And I follow "Create Account"
    And  I fill in "company_name" with "The Goods Company"
    And  I fill in "company_description" with "A very goods company"
    And  I fill in "company_address" with "addressed all the goods"
    And  I fill in "company_email" with "goods@goodygoods.com"
    And  I fill in "company_image_url" with "notfound.com"
    And  I fill in "company_username" with "anewone"
    And  I fill in "company_password" with "1234567"
    And I press "Create Merchant Account"
    Then I should see "Password must be at least 8 characters long"

  Scenario: Sign up a merchant
    When I go to the home page
    And I follow "Login"
    And I follow "Are you a merchant?"
    And I follow "Create Account"
    And  I fill in "company_name" with "The Goods Company"
    And  I fill in "company_description" with "A very goods company"
    And  I fill in "company_address" with "addressed all the goods"
    And  I fill in "company_email" with "goods@goodygoods.com"
    And  I fill in "company_image_url" with "notfound.com"
    And  I fill in "company_username" with "goodscompany"
    And  I fill in "company_password" with "abcdeghi"
    And I press "Create Merchant Account"
    Then I should see "Login"

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

  Scenario: View user profile
    When I go to the home page
    And I follow "a long String"
    Then I should not see "User Testimonials"