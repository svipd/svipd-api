Feature: search products using wishlist

  As a customer
  To search a bunch of products near me
  I want to be able to add them to a wishlist

  Background: On svipd homepage
    Given the following companies exist:
      | name                 | description | address                            | password                         | image_url | company_id | username |
      | Columbia University  | test        | 600 w 116th st, new york, ny 10027 | 9dd4e461268c8034f5c8564e155c67a6 | x         | 1          | dsfd     |
      | Columbia University2 | test        | 600 w 116th st, new york, ny 10027 | 9dd4e461268c8034f5c8564e155c67a6 | x         | 2          | dsfdsfsd |
    Given the following users exist:
      | username | fname          | lname            | password                         | id |
      | user1    | a long String  | sanename         | 9dd4e461268c8034f5c8564e155c67a6 | 1  |
      | user2    | @nother $tr1ng | not_ soSaNe Name | 9dd4e461268c8034f5c8564e155c67a6 | 2  |
    Given the following carts exist:
      | id | wishlist | user_id |
      | 1  |          | 1       |
      | 2  |          | 2       |
    Given the following products exist:
      | pid | name      | description | price | stock_count | company_id | image_url                                                                                                                        | barcode |
      | 1   | Star Wars | PG          | 5     | 5           | 1          | https://secure.img1-fg.wfcdn.com/im/23512985/resize-h800-w800%5Ecompr-r85/9718/97183556/VFAN+Jr.+Vintage+6%2522+Personal+Fan.jpg | 123     |
      | 2   | books     | Intelligent | 25    | 15          | 1          | https://secure.img1-fg.wfcdn.com/im/23512985/resize-h800-w800%5Ecompr-r85/9718/97183556/VFAN+Jr.+Vintage+6%2522+Personal+Fan.jpg | 456     |
      | 3   | xyz       | xyz         | 25    | 15          | 2          | https://secure.img1-fg.wfcdn.com/im/23512985/resize-h800-w800%5Ecompr-r85/9718/97183556/VFAN+Jr.+Vintage+6%2522+Personal+Fan.jpg | 789     |
    When I go to the home page
    And I follow "Login"
    And  I fill in "username" with "user1"
    And  I fill in "password" with "x"
    And I press "Login"


  Scenario: Add to wishlist
    When I go to the home page
    And I fill in "search_search" with "Star Wars"
    And I press "button"
    And I press "Add to Wishlist"

  # @Javascript
  # Scenario: See wishlist
  #   When I go to the home page
  #   And I fill in "search_search" with "star"
  #   And I press "button"
  #   And I press "Add to Wishlist"
  #   And I wait 8 seconds
  #   And I follow "Wishlist"
  #   Then I should see "Star Wars"
  #   And I fill in "distance_distance" with "1000000"
  #   And I press "Search"
  #   Then I should see "Available at"
  #   And I should see "Columbia University"
