cv-rb
=====

# Small interative rails console (authentication required)  
Dependency : install `apt-get install libicu48`   

## Running tests and launching the app
* `bundle install`  
* Copy database.yml.sample to database.yml and put your username/password
* Run `rake db:create` then `rake db:migrate` then `rake db:test:prepare`
* Optional : seed the dev db while you're here : `rake db:seed_fu`
* Then run `rspec`. It uses capybara-webkit for integration tests, therefore make sure you install Qt first (see capybara-webkit github page)

