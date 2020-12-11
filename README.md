# Backend Challenge

## Learning Competencies
- Implement Object Oriented Design.
- Good usage of git.
- comprehensive tests.
- Good implementation of logic.

## Setup
To setup:
```bash
 ruby setup.rb || ruby setup.rb --help
```
To run spec:
```bash
 rspec .
```
To start server:
```bash
  rails s
```

## Summary
This challenge was completed in 2 days. It was quite an experience. Listed below are things I enjoyed.

- Implement render of JSON
- Implement Rest API and Authentication
- Implementing comprehensive specs.
- Frequent git commits.

Here are some things I would like to improve in my implementation:
- STI (Single inheritance table) for types of transaction:
  At the moment, I didn't deem it necessary(factoring time constraint) to implement STI for the types of transactions. Below is an illustration of what could be implemented for the type when/if the states and behaviours are significantly different.

  ```bash
    change_column :transactions, :type, :string, null: false
  ```

  ```bash
    class Transation; end
  ```

  ```bash
    class Income < Transaction; end
  ```

  ```bash
    class Expense < Transaction; end
  ```

- Due to time constrainst was unable to provide:
  - Use docker container for development setup
  - Provide a clear API documentation

# The challenge

We would like you to create REST API with these requirements. The REST API
should connect to a database either Postgres, MySql, or Sqlite.

## Review
#### User:
As a user should to be able to register to Corgee
The minimum information that is needed to input to register to Corgee are:
- first name
- last name
- email
- password
- repeated password

To log in to Corgee, a user needs to provide a valid email & password.

#### Transactions
As a login user, user should able to create, read, update and delete his
transactions.

These endpoints should have authentication. The minimum information for a
transaction are:
- description
- amount
- type (expense or income)
