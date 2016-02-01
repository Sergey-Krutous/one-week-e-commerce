This application is developed as Ruby-on-Rails learning exsercise.
The application reprsents a simple e-commerce platform that could be created in one week.

## Ruby version

This application was developed with Ruby version 2.2.1p85 (2015-02-26 revision 49769) [x86_64-linux].

## How to setup the application

1. Download the source code:
`git clone https://github.com/Sergey-Krutous/one-week-e-commerce.git`
2. Update the gems requred for the application:
`bundle install`
3. Upgrade DB schema:
`rake db:migrate`
4. Set admin login and password in SessionsController (ADMIN\_LOGIN and ADMIN\_PASS constants) to appropriate values. Do not check in the changed file to GitHub (or any other publicly available repository).
5. Run Rails server:

`rails server`

## How to test

Execute `rspec -c -f d` to run the test suite.

## Notes

I used SQLite as RDBMS to have zero configuration efforts.

I used Awesome Nested Set gem as the most popular gem in "Active Record Nesting" section of the Ruby Toolbox: https://www.ruby-toolbox.com/categories/Active_Record_Nesting.

I used Carrierwave gem as the second popular gem in "Rails File Uploads" section of the Ruby Toolbox: https://www.ruby-toolbox.com/categories/rails_file_uploads. However, the API of Carrierwave seems more intuitive to me than Paperclip API.

I was updating some of migrations given I was the only developer and could run `rake db:migrate:redo` or even `rake db:reset`. When working within a team the migrations should be incrementally added instead of modified. 

I designed Basket items controller to accept AJAX requests (format=js) at the first place. However I encountered an issue with integration testing of "Add to cart" button in Selenium. It seemed like I needed to downgrade FireFox (http://stackoverflow.com/questions/7263564/unable-to-obtain-stable-firefox-connection-in-60-seconds-127-0-0-17055?rq=1). As it seemed to be a long way to fix and taking into account time constraints I chose to workaround the issue by additionally rendering for format=html. 

### Testing strategy

Validation rules are tested with model tests.

Admin section of the application was tested with controller RSpec tests because:

1. these tests are lighter than integration (request) tests
2. admin UI provides only simple CRUD operations

Routing tests are included into the test suite because:

1. they are usually automatically generated by scaffold generator; so they are very easy to create and update
2. they ensure that controller actions can be routed to

Helpers were not covered with tests because they provide very simple methods that would require tests duplicating helpers logic.

Several integration tests (located at spec/features) were created to ensure end-to-end scenarios:

1. products integration tests ensure that:
  - product can be created with admin section of the application
  - the product appears in the product list page (PLP) of the assigned category at the public section of the application
  - the product detail page (PDP) can be opened by product id and product slug

2. checkout integration tests ensure that:
  - a product can be added to the basket from PDP opened by product id
  - the product can be added to the basket from PDP opened by product slug
  - the user can proceed to checkout with this basket
  - and submit the order
  - this order will be visible in the admin section of the application

Integration tests cover mainly "sunny day" scenarios. Alternative scenarios are covered by model or controller tests.

## 1st priority TODOs (known issues):

1. Admin password and login are stored as string constants in SessionsController. These must be moved to secrets file that is not version-controlled.
2. Image files are not deleted from public folder
3. Image files are stored in their original sizes and resized by the browser even if a thumbnail is needed. This implementation hits the traffic. The application should generate and store resized images.
4. The images are stored locally. A better solution would be to store the images in CDN.
