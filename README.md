# sVipd ASE Project

Azhaan Zahabee - az2641 <br />
Harjot Singh - hs3263 <br />
James Mastran - jam2454 <br />
Swapnil Paliwal - sp3911 <br />

Testing Suite:
 - We have implemented tests in RSpec with about 85+% code coverage
 - We have implemented tests in Cucumber with about 90+% code coverage
 - Our testing suite may be run with `./run_tests.sh`
 - In total, we have 97+% code coverage

---------------------- README -----------------------------

m: sVipd (#22); SWAPNIL PALIWAL (sp3911), JAMES MASTRAN (jam2454), HARJOT SINGH (hs3263), AZHAAN ZAHABEE (az2641)

Github link: https://github.com/svipd/svipd-api
Tagged as iteration2

Heroku link: https://svipd.herokuapp.com/


I.	Introduction

sVipd is a platform that enables end-user to learn what is new in their locality (offers, discounts, new arrivals, etc.) and
learn where they can find a particular product around them. The product search can be done by searching a product by its name
or scanning the barcode. Businesses can advertise or broadcast essential information to individuals in the form of sVipd alerts (story).

II.     Our Evolution

In our last iteration, we made greate progress on defining the feel of our website. However, this iteration we made strides in adding many
features and pivoting our level of abstraction. In the last iteration, we focused heavily on merchants and their products, but this iteration 
we changed those specific functions to be more compatible for many stakeholders. Now our website handles users/customers as well as
merchants with an emphasis on the former. We hope you enjoy sVipd!

III.	Key Features

  1. sVipd Alerts: Our website can be accessed at https://svipd.herokuapp.com/. The stories in the trending section are sVipd alerts. A brand name and
     other pertinent information to the merchant’s story can be seen when clicked.

  2. User login and account creation: Click "login" at the top of the screen. Some usable login credentials are username: "test" and password: "carttest". Alternatively, 
     you may create an account with the create account button.

  3. Merchant login (and authentication) and account creation: Click "login" in the header. Then click the "Are you a merchant?" link. 
     You can log in using the username "Walmart" and the password as "x". Alternatively, you can create a company using the create merchant button.

  3. Product search: On the homepage, anyone can search for products that are available.

  4. View a company: After searching for products, one can click the company's button found in the product's card. Here, the user can search that merchant's
     entire list of products. In addition, the user can sort by price or name in ascending or descending order.

  5. (Must be logged in as a user) Likes and Wishlist: The user can add products to their likes by clicking the "like" button after searching for products. 
     These liked products show up on the user's profile page (accessed via the "Profile" link in the header--must be logged in). 

     IMPORTANT FEATURE: The user can add to their wishlist using the "Add to Wishlist" button. These items can then be seen in the "wishlist" 
     link (in the header). The user can then provide a radius for the search and our algorithm will find all the stores that have all
     the items available in the user's wishlist and give the cheapest place to purchase from in a list.

  6. Wishlist: See above. Used to find the best total price for all the items a user wants.

  7. Profile page: See above. Used to show what a user likes.

  8. Sorting & Search by Company: Added sorting functionality and search by company accessed after searching products and clicking on a company's button.

  9. Location Finding & Math: We locate a user's location and added algorithms to find the distance from the user to the products available.

  10. Improved Stories: We added a cleaner look to our stories.

  11. Improved merchant landing page: Now whena  merchant logs in, they are greeted.

  12. Added flash header warnings/notices/successes for various failures or other urgent messages to give the user feedback.
  

IV.	Testing information

Our testing suite includes RSpec tests and Cucumber tests using packages such as FactoryGirl and others. 
To run our tests, there is a shell script (Run with ./run_tests.sh) that will run the RSpec tests, then 
migrates our test database (SQLite3—which differs from our postgresql database hosted on an AWS server), 
and then runs Cucumber tests. We are achieving 95%+ code coverage with about 4 hits per line as per our 
coverage report. We used simpleCov as well. The simpleCov report should be generated after running the tests. 
Note: if the shell script does not work, or is unable to be run, the commands are listed in the run_tests.sh and 
are just the simple bundle exec rake cucumber or bundle exec rspec. Also, the tests pass on linux-based computers, 
Ubuntu, or WSL, but in some cases have had trouble on certain Windows machines. Please let us know if you have any 
difficulties running our tests.

Iteration 2: We added more tests for the many more features we have added. We maintain about a 94% code coverage with
about 8 hits per line.

V.	Running Server

Running the Rails server should be as easy as completing bundle install, and rails server, assuming you have Rails set up.
