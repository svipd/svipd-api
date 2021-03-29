Feature: search for movies by director

  As a merchant
  So that I can sell more items
  I want to list my products for sale

Background: products and companies in database

  Given the following companies exist:
  | name        | description | address                             | image_url | company_id  | username | password
  | Test Co     | test        | 600 w 116th st, new york, ny 10027  |   "x"     | 1           | sdfsdf    | dsfdsf
  Given the following products exist:
  | pid | name        | description | price     | stock_count | company_id  |
  | 1   | Star Wars   | PG          | 5         |   5         | 1           |
  | 2   | Star Wars22 | PG          | 5         |   5         | 1           |

Scenario: View products
  When I go to the products page
  Then I should see "Search Result"
  And I should see "Star Wars"

Scenario: View a product
  When I go to the products page
  And I follow "Star Wars"
  Then I should see "Test Co"
  And I should see "Star Wars"
  And I should not see "Star Wars22"

Scenario: Delete a product
  When I go to the products page
  And I follow "Star Wars22"
  And I follow "Delete This Product"
  Then I should not see "Star Wars22"

Scenario: Edit a product
  When I go to the products page
  And I follow "Star Wars22"
  And I follow "Edit"
  And  I fill in "product_name" with "Star Wars33"
  And I press "Update Product"
  Then I should not see "Star Wars22"
  And I should see "Star Wars33"

Scenario: Add product to table
  # TODO: This should not work because we do not have
  # our merchant_id in session
  When I go to the new product page
  And  I fill in "product_name" with "Ridley Scott"
  And  I fill in "product_description" with "Ridley Scott"
  And  I fill in "product_price" with "1"
  And  I fill in "product_stock_count" with "1"
  And  I press "Add Product"
  Then product id 2 does not exist
