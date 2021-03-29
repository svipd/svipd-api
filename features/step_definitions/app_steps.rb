
Given /the following products exist/ do |products_table|
  products_table.hashes.each do |product|
    Product.create product
  end
end

Given /the following companies exist/ do |companies_table|
  companies_table.hashes.each do |company|
    Company.create company
  end
end

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create user
  end
end

Given /the following stories exist/ do |stories_table|
  stories_table.hashes.each do |story|
    Story.create story
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

Then('product id {int} has {string} in  {string}') do |e1, e2, e3|
  expect(Product.find(e1).select(e2).include? e3)
end
Then('product id {int} does not have {string} in  {string}') do |e1, e2, e3|
  expect(Product.find(e1).select(e2).include? e3 == false)
end
Then('product id {int} does not exist') do |e1|
  expect(Product.where(:pid => e1).present? == false)
end

Then /I should see all the products/ do
  # Make sure that all the movies in the app are visible in the table
  Product.all.each do |product|
    step %{I should see "#{product.name}"}
  end
end
# Then the director of "(.*)" should be "(.*)"/ do |movie, director|
#   # Make sure that all the movies in the app are visible in the table
#   expect(Movie.find_by_title(movie).director == director)
# end