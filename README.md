This application is developed as Ruby-on-Rails learning exsercise.
The application reprsents a simple e-commerce platform that could be created in one week.

## Ruby version

This application was developed with Ruby version 2.2.1p85 (2015-02-26 revision 49769) [x86_64-linux].

## How to setup the application

Set admin login and password in SessionsController (ADMIN_LOGIN and ADMIN_PASS constants) to appropriate values. Do not check in the changed file to GitHub (or any other publicly available repository).

## How to test

Execute `rspec -c -f d` to run the test suite.

## Notes

Awesome Nested Set gem was selected as the most popular gem in "Active Record Nesting" section of the Ruby Toolbox: https://www.ruby-toolbox.com/categories/Active_Record_Nesting.

I was updating some of migrations given I was the only developer and could run `rake db:migrate:redo` or even `rake db:reset`. When working within a team the migrations should be incrementally added instead of modified. 

Admin password and login are stored as string constants in SessionsController. These must be moved to secrets file that is not version-controlled.

### Testing strategy

Admin section of the application was tested with controller RSpec tests because:
1) these tests are lighter than integration (request) tests
2) admin UI provides only simple CRUD operations

Routing tests are included into the test suite because:
1) they are usually automatically generated by scaffold generator; so they are very easy to create and update
2) they ensure that controller actions can be routed to

Helpers were not covered with tests because they provide very simple methods that would require tests duplicating helpers logic.

