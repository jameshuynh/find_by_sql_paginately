# find_by_sql_paginately

This gem is to add extra parameters to Rails original method ``find_by_sql`` so that developers like us can do pagination without so much hassle of manipulating the SQL.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'find_by_sql_paginately', '~> 0.1.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install find_by_sql_paginately

## Usage

With this gem install you can run the normal ``find_by_sql`` but with extra parameters per_page and page like below. Note that, there would be 3 extra methods ``total_pages``, ``total_count``, ``page`` that you can used to faciliate the pagination rendering.

```ruby
users = User.find_by_sql('SELECT * FROM users', per_page: 10, page: 1)
# => First page of 10 users will be returned

users.total_pages
# => Total Pages
users.total_count
# => Total Records
users.page
# => Current Page
```

You also can run the SQL with variable replacement like followings:

```ruby
users =
  User
  .find_by_sql(
    ['SELECT * FROM users WHERE id > ?', 1],
    per_page: 10,
    page: 1
  )

# OR

users =
  User
  .find_by_sql(
    ['SELECT * FROM users WHERE id > :id', { id: 1 }],
    per_page: 10,
    page: 1
  )
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jameshuynhfind_by_sql_paginately. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FindBySqlPaginately project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/find_by_sql_paginately/blob/master/CODE_OF_CONDUCT.md).
