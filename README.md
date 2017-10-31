# README

Bambank Example Application

#### Assumptions

* Accounts require email no validation
* There is no transaction fee
* Promotion is active or inactive, no end dates, for simplicity
* No need for admin functions at this point

#### Below are the requirements for the system running this application

* System dependencies
    * MySQL 5.7
    * Rails 5.1.4 
    * Ruby 2.4.2

* Application Setup (Development)
    * Setup ENV Variables
        * BAMBANK_DATABASE_USER
        * BAMBANK_DATABASE_PASSWORD
    * Run the below commands in terminal
        * bundle install
        * rake db:create
        * rake db:migrate db:seed
    * Start the server
        * rails s Puma
    
* Application Setup (Production)
    * Setup ENV Variables
        * SECRET_KEY_BASE
        * BAMBANK_DATABASE_USER
        * BAMBANK_DATABASE_PASSWORD
    * Run the below commands in terminal
        * bundle install
        * RAILS_ENV=production rake db:create
        * RAILS_ENV=production rake db:migrate db:seed
        * RAILS_ENV=production bundle exec rake assets:precompile
    * Start the server
        * rails s Puma -e production



