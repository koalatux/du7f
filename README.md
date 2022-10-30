# du7f
du7f is a simple web-based polling tool using the Ruby on Rails framework.

## See it in Action
An instance is running over there [du7f.koalatux.ch](https://du7f.koalatux.ch/).

## Start Development
For development you need a recent ruby version, I recommend [rbenv](https://github.com/rbenv/rbenv) for managing ruby
versions. Make sure to install the version of ruby mentioned in the [.ruby-version](.ruby-version) file.

Make sure you have the bundler gem installed

```bash
gem install bundler
```

Then install all dependencies using bundler by running the following command in the top level directory of du7f

```bash
bundle install
```

Create and initialize the database

```bash
bundle exec rake db:setup
```

Then you may start a local development instance of du7f and point your browser to
[http://localhost:3000/](http://localhost:3000/)

```bash
bundle exec rails server
```

Or run all tests:

```bash
bundle exec rake test
```

## Database
du7f has only been tested using SQLite as a database. But might work as well with others.

## Source Code
The source code of du7f is available at [GitHub](https://github.com/koalatux/du7f).

## Note about the SQLite adapter
If you are using the SQLite adapter and are upgrading from a du7f version which
uses a Rails version before 5.2, you need to convert booleans from strings to
integers in your database, because booleans as strings is depraced with Rails
5.2. You might use the provided rake task.

```bash
RAILS_ENV=production bundle exec rake sqlite_boolean_as_integer:convert_to_int
```
