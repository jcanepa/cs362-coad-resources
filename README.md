# Central Oregon COAD

This is the GitHub repository for the Central Oregon Community Organizations Active
in Disaster (COAD) help service system. It connects people in need with resources
made available by members of Community Organizations Active in Disaster.

## Development

Fork the repository:

[https://github.com/ybakos/cs362-coad-resources](https://github.com/ybakos/cs362-coad-resources)

And then clone it to your local development environment, eg:

```
git clone git@github.com:YOURFORK/cs362-coad-resources.git
```

This is a Rails application that uses SQLite in development and PostgreSQL in production.

Prerequisites:
Install a Ruby version manager like [rbenv](https://github.com/rbenv/rbenv) or [rvm](https://github.com/rvm/rvm). Use these utilities to install the appopriate version of Ruby as specified in the Gemfile. Ruby version 2.7.2, Rails version 5.2.4.6.

Using `rvm`:

```
rvm install "ruby-2.7.2"
```

Next, verify you are running the desired version:

```
rvm list
```

Depending on your environment, you may need to ensure you have `mimemagic` installed, version 0.3.10.

Install the dependencies:

```
gem install bundler
bundle install
```

Next, set up the database:

```
rails db:setup
```

If you want, you can create some seed data in the database:

```
rails db:seed
```

Start the app:

```
rails server
```

## Environment configuration file

Copy `.env.example` to new file `.env` and fill in required environment variables.

```
cp .env.example .env
```

## Testing

This project uses RSpec for testing.

```
rspec
```

You can also run a specific directory of tests or file by supplying its name, like so:

```
spring rspec spec/path/to/file_spec.rb
```

## Deployment

This application uses [heroku for deployment](https://devcenter.heroku.com/articles/git).
Some useful commands to know can be found below.

Set up a heroku app to deploy to:

```
heroku git:remote -a coad-resources-staging
heroku git:remote -a coad-resources

```

Rename them _staging_ and _production_:

```
git remote rename coad-resources-staging staging
git remote rename coad-resources production

```

Deploy to a heroku app:

```
git push staging
```

Migrate the rails database of a heroku app:

```
heroku run rails db:migrate --remote staging
```

Seed the rails database of a heroku app:

```
heroku run rails db:seed --remote staging
```

Set environment variables (see _.env.example_ for expectations):

```
heroku config:set FOO=bar
```

## Production Dependencies

- PostgreSQL
- Email Server (Gmail)
- Recaptcha

## Data model

![erd](public/documentation/erd.jpg?raw=true)

&copy; 2020 James Martinez, Ryder McDowell. All rights reserved.
