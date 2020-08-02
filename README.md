## Inject Some SQL

These are sample Rails applications for demonstrating many ways SQL can be injected in Rails.

### Setup

Clone the repo:

```
git clone https://github.com/presidentbeef/inject-some-sql.git
```

Pick either Rails 5, Rails 4 or Rails 3. They each have their own subdirectory.

```
cd inject-some-sql/rails5
```

In the subdirectory, install dependences and set up the database:

```
bundle install
rake db:setup db:seed
```

### Run

Typical Rails start:

```
rails s
```

Open up [localhost:3000](http://localhost:3000) in a browser.

### Reset Database

It's easy to mess up a database with SQL injection. The server does attempt to
reset the database after each query, but that isn't foolproof.

To completely reset:

```
rake db:drop db:migrate db:seed
```

### Inject SQL!

The site lists a whole bunch of ActiveRecord queries.

Each query has input for a single parameter (although some queries may actually
have more than one). A sample injection is provided. Clicking "Run!" will run
the query shown.

## Docker

Alternatively, Docker can be used. Only available for Rails 5 for now.

### Setup

```
cd inject-some-sql/rails5
docker-compose build
```

### Run

```
docker-compose up
```

## Adding/Modifying Queries

All queries are generated from `app/models/queries.rb`.

## Limitations

* This is a single player game because the SQL query is stored in a global variable.

## License

This code is made available under the MIT license.
