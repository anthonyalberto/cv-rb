cv-rb
=====

# Small interative rails console (authentication required)  
Dependency : `apt-get install libicu48 libxslt-dev libxml2-dev libqtwebkit-dev libmagickwand-dev imagemagick libmagickcore-dev`

## Running tests and launching the app
* `bundle install`  
* Copy database.yml.sample to database.yml and put your username/password
* Run `rake db:create` then `rake db:migrate` then `rake db:test:prepare`
* Optional : seed the dev db while you're here : `rake db:seed_fu`
* Then run `rspec`.

