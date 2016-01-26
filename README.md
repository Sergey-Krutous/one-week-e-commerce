This application is developed as Ruby-on-Rails learning exsercise.
The application reprsents a simple e-commerce platform that could be created in one week.

## Ruby version

This application was developed with Ruby version 2.2.1p85 (2015-02-26 revision 49769) [x86_64-linux].

## How to test

Execute `rspec -c -f d` to run the test suite.

## Notes

Awesome Nested Set gem was selected as the most popular gem in "Active Record Nesting" section of the Ruby Toolbox: https://www.ruby-toolbox.com/categories/Active_Record_Nesting.

### Testing strategy

Admin section of the application was tested with controller RSpec tests because:
1) these tests are lighter than integration (request) tests
2) admin UI provides only simple CRUD operations

Helpers were not covered with tests because they provide very simple methods that would require tests duplicating helpers logic.

