## Inject Some SQL

This is a sample Rails application for demonstrating many ways SQL can be injected in Rails.

### Setup

Clone the repo, install the dependencies, and setup the database:

```
git clone https://github.com/presidentbeef/inject-some-sql.git
cd inject-some-sql
bundle install
rake db:migrate db:seed
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

## Adding/Modifying Queries

All queries are generated from `app/models/queries.rb`.

## Limitations

* This is a single player game because the SQL query is stored in a global variable.

## License

This code is made available under the MIT license.
