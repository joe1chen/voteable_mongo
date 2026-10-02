# voteable_mongo

[![CI RSpec Test](https://github.com/joe1chen/voteable_mongo/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/joe1chen/voteable_mongo/actions/workflows/test.yml)

Up / down voting for **Mongoid** documents. All vote data lives inside the voted document itself, and every
vote, re-vote and un-vote is validated, applied and read back in **one atomic `findAndModify`** — no separate
votes collection, no extra queries to show counts or points.

This is the [DOGOnews](https://www.dogonews.com)-maintained fork of
[rs-pro/voteable_mongo](https://github.com/rs-pro/voteable_mongo) (upstream has been inactive since 2018). It is
kept working on current Ruby, Rails, Mongoid and MongoDB versions.

## Supported versions

Tested on every push by the [GitHub Actions matrix](https://github.com/joe1chen/voteable_mongo/actions/workflows/test.yml)
([workflow](.github/workflows/test.yml)):

| Ruby | Rails | Mongoid | MongoDB |
|---|---|---|---|
| 2.7 | 6.1 | 7.5 | 6.0 |
| 3.0 | 6.1 | 8.0 | 6.0 |
| 3.1 | 7.0 | 8.1 | 7.0 |
| 3.2 | 7.1 | 8.1 | 7.0 |
| 3.2 | 7.2 | 9.0 | 7.0 |
| 3.3 | 7.2 | 9.0 | 8.0 |
| 3.4 | 8.0 | 9.0 | 8.0 |
| 2.7 | 6.1 | 7.5 (driver 2.26) | 8.0 |

The gemspec allows `mongoid >= 7.0, < 10`.

## Installation

This fork is not published to RubyGems; install it from GitHub, pinned to a release tag
([releases](https://github.com/joe1chen/voteable_mongo/releases)):

```ruby
# Gemfile
gem 'rs_voteable_mongo', github: 'joe1chen/voteable_mongo', tag: 'v1.4.0'
```

Then `bundle install`. In Rails the rake tasks below are registered automatically (via a Railtie).

## Usage

### Make documents voteable and users voters

```ruby
class Post
  include Mongoid::Document
  include Mongo::Voteable

  # points awarded for each vote on this document
  voteable self, up: +1, down: -1

  has_many :comments
end

class Comment
  include Mongoid::Document
  include Mongo::Voteable

  belongs_to :post

  voteable self, up: +1, down: -3

  # a vote on a comment can also change the related post's counts and points
  voteable Post, up: +2, down: -1
end

class User
  include Mongoid::Document
  include Mongo::Voter
end
```

### Vote

```ruby
@user.vote(@post, :up)

# equivalent forms
@user.vote(votee: @post, value: :up)
@post.vote(voter: @user, value: :up)

# without loading the voter and/or votee (e.g. in an API endpoint)
@user.vote(votee_class: Post, votee_id: post_id, value: :down)
@post.vote(voter_id: user_id, value: :up)
Post.vote(voter_id: user_id, votee_id: post_id, value: :up)
```

Change or remove an existing vote:

```ruby
Post.vote(voter_id: user_id, votee_id: post_id, value: :down, revote: true)  # re-vote
Post.vote(voter_id: user_id, votee_id: post_id, value: :up,   unvote: true)  # un-vote
@user.unvote(@comment)
```

`vote` always returns the updated votee.

### Read vote data

```ruby
@user.vote_value(@post)                                  # => :up, :down or nil
@user.vote_value(votee_class: Post, votee_id: post_id)
@post.vote_value(@user)
@post.vote_value(user_id)

@user.voted?(@post)
@user.voted?(votee_class: Post, votee_id: post_id)
@post.voted_by?(@user)
@post.voted_by?(user_id)

@post.votes_point
@post.votes_count
@post.up_votes_count
@post.down_votes_count
```

### Query voters and voted documents

```ruby
@post.up_voters(User)        # or User.up_voted_for(@post)
@post.down_voters(User)      # or User.down_voted_for(@post)
@post.voters(User)           # or User.voted_for(@post)

Post.voted_by(@user)
Post.up_voted_by(@user)
Post.down_voted_by(@user)
```

## Maintenance tasks

| Purpose | Rake (Rails) | Ruby |
|---|---|---|
| Set counters/points to 0 on documents that have never been voted on (so they sort and filter correctly) | `rake mongo:voteable:init_stats` | `Mongo::Voteable::Tasks.init_stats` |
| Recompute counters and points, e.g. after changing the `up:`/`down:` values | `rake mongo:voteable:remake_stats` | `Mongo::Voteable::Tasks.remake_stats` |
| Migrate vote data written by voteable_mongoid < 0.7.0 | `rake mongo:voteable:migrate_old_votes` | `Mongo::Voteable::Tasks.migrate_old_votes` |

## Development

```bash
# needs a MongoDB on localhost:27017 (e.g. docker run -p 27017:27017 mongo:8.0)
MONGOID_VERSION=9.0 RAILS_VERSION=8.0 bundle install
MONGOID_VERSION=9.0 RAILS_VERSION=8.0 bundle exec rspec spec
```

`MONGOID_VERSION` and `RAILS_VERSION` select the versions in the `Gemfile` (defaults: Mongoid 7.5, no Rails pin).
To add a combination to CI, add a row to `matrix.include` in `.github/workflows/test.yml`.

## Known issues

- `Mongo::Voteable::Voting.vote` rescues `Moped::Errors::OperationFailure` (from the Mongoid 3/4 era). `Moped`
  no longer exists, so if `find_one_and_update` ever raises, that line itself raises `NameError` instead of
  returning `nil`. It is not exercised by the specs; it should become `Mongo::Error::OperationFailure`.

## History

Alex Nguyen's original (2010, Vinova, published as `voteable_mongoid` and renamed `voteable_mongo` in 0.8.0) was
continued by RocketScience (rs-pro) as `rs_voteable_mongo` 1.0.0–1.3.0 (2013–2018: Mongoid 3–7, MongoMapper
dropped) and by DOGOnews in this fork: 1.4.0 (2026: Mongoid 7.0–9.x on current Ruby/Rails/MongoDB, tested by a
GitHub Actions matrix).
See [CHANGELOG.md](CHANGELOG.md).

## Credits

- Alex Nguyen — original author
- RocketScience / rs-pro — Mongoid 3–7 fork
- [Contributors](https://github.com/joe1chen/voteable_mongo/graphs/contributors)

Copyright (c) 2010–2011 Vinova Pte Ltd. Licensed under the MIT license.
