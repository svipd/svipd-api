Feature: update profile

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
    Given the following posts exist:
      | id | user_id    | title                 | image        | message     |
      | 1  | 1          | I love this!          | "http://..." | xyz         |
  
  Scenario: Update user profile
    When I go to the home page
    And I follow "Login"
    And  I fill in "username" with "user1"
    And  I fill in "password" with "x"
    And I press "Login"
    And I follow "Profile"
    And I press "Edit Profile"
    And I press "Update Profile"
    Then I should see "success"  
    
  Scenario: User makes new post
    When I go to the home page
    And I follow "Login"
    And  I fill in "username" with "user1"
    And  I fill in "password" with "x"
    And I press "Login"
    And I follow "Profile"
    And I press "Add Post"
    And I fill in "new_post_title" with "user1"
    And I fill in "new_post_message" with "this is a new post user1"
    And I fill in "new_post_image" with "x@g.com"
    And I press "Post!"
    Then I should see "this is a new post user1"
    And I should see "Posts"
    
  Scenario: User edits post
    When I go to the home page
    And I follow "Login"
    And  I fill in "username" with "user1"
    And  I fill in "password" with "x"
    And I press "Login"
    And I follow "Profile"
    And I press "Edit"
    And I press "Update Post"
    Then I should see "success"

  Scenario: User deletes new post
    When I go to the home page
    And I follow "Login"
    And  I fill in "username" with "user1"
    And  I fill in "password" with "x"
    And I press "Login"
    And I follow "Profile"
    And I press "Edit"
    And I follow "Delete"
    Then I should see "Delete"