# du7f #

du7f is a simple web-based polling tool using the Ruby on Rails framework.

## See it in Action

Am instance is running over there [du7f.koalatux.ch](http://du7f.koalatux.ch/).

## Start Development ##

For development you need a recent ruby version, I recommend [rbenv](https://github.com/rbenv/rbenv) for managing ruby
versions. Make sure to install the version of ruby mentioned in the [.ruby-version](.ruby-version) file.

Make sure you have the bundler gem installed

    gem install bundler

Then install all dependencies using bundler by running the following command in the top level directory of du7f

    bundle install

Create and initialize the database

    bundle exec rake db:setup

Then you may start a local development instance of du7f and point your browser to
[http://localhost:3000/](http://localhost:3000/)

    bundle exec rails server

Or run all tests:

    bundle exec rake test

## Database ##

du7f has only been tested using SQLite as a database. But might work as well with others.

## Source Code ##

The source code of du7f is available at [GitHub](https://github.com/koalatux/du7f).