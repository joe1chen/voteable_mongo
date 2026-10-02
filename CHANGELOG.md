# Changelog

All notable changes to this project are documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- CI: test Mongoid 7.5 with Ruby driver 2.26 against MongoDB 8.0 (Ruby 2.7 / Rails 6.1).

## [1.4.0] - 2026-10-01
DOGOnews fork. Minor version because the minimum supported Mongoid is unchanged (7.0, as in 1.3.0) and the public
API did not change.

### Added
- Mongoid 8 and 9 support (no library code changes were needed; the specs only needed the RSpec 3 matcher renames, `be_true` → `be_truthy`).
- GitHub Actions test matrix (`.github/workflows/test.yml`), seven rows from Ruby 2.7 / Rails 6.1 /
  Mongoid 7.5 / MongoDB 6.0 to Ruby 3.4 / Rails 8.0 / Mongoid 9.0 / MongoDB 8.0. The `Gemfile` selects
  Mongoid and Rails from `MONGOID_VERSION` / `RAILS_VERSION` (default Mongoid 7.5, no Rails pin).
- GitHub Release workflow (`.github/workflows/release.yml`): pushing a `vX.Y.Z` tag creates a GitHub Release
  with this file's section as the notes.

### Changed
- Runtime dependency `mongoid >= 7.0, < 10` (was `~> 7.0`).
- Specs run on RSpec 3.13 (keeping the `should` syntax, enabled explicitly); development dependency
  `rake >= 10` (was `< 11.0`, which could not resolve with Rails 7 and 8).
- The gemspec `homepage` points to this fork.
- README rewritten as `README.md` for the maintained fork (supported versions, usage, maintenance tasks, known
  issues); history moved to this file (`CHANGELOG.rdoc` converted).

### Removed
- Travis CI configuration and `README.rdoc`.

## [1.3.0] - 2018-11-20
### Changed
- Runtime dependency `mongoid ~> 7.0` (was `~> 6.0`).

## [1.2.0] - 2017-03-21
### Changed
- Runtime dependency `mongoid ~> 6.0` (was `~> 5.0`); development dependency `rake < 11.0`.

## [1.1.0] - 2016-02-24
### Changed
- Mongoid 5 support: runtime dependency `mongoid ~> 5.0` (was `>= 3.0, < 5.0`); votes are applied with
  `find_one_and_update` and counters with `update_many` (Mongoid 5 / Ruby driver 2 API); the Moped code path is
  removed.

## [1.0.2] - 2013-10-03
### Fixed
- `lib/rs_votable_mongo.rb` renamed to `lib/rs_voteable_mongo.rb`, matching the gem name.

## [1.0.1] - 2013-10-03
### Removed
- MongoMapper leftovers (the Mongoid integration is always used).

### Fixed
- `lib/rs_votable_mongo.rb` required the non-existent `votable_mongo`.

## [1.0.0] - 2013-09-29
### Changed
- Forked by RocketScience as `rs_voteable_mongo`: Mongoid 3 and 4 support (Moped 2 / BSON 2), runtime dependency
  `mongoid >= 3.0, < 5.0`.

### Removed
- MongoMapper support.

## [0.9.3] - 2011-10-08
### Changed
- Supports `mongoid ~> 2.0` and `mongo_mapper ~> 0.9`; keys that are not ObjectIds are supported.

## [0.9.2] - 2011-05-07
### Changed
- `votee_type` replaced by `votee_class`.

### Fixed
- Parent stats are updated for multiple parent documents; voting on a missing document no longer raises.

## [0.9.1] - 2011-05-04
### Changed
- Gem description.

## [0.9.0] - 2011-05-04
### Added
- MongoMapper support.

### Changed
- Simpler voting algorithm; vote, revote and unvote always return the votee.

### Fixed
- `Tasks` module bugs.

## [0.8.1] - 2011-05-03
### Fixed
- Gem release bug in the gemspec.

## [0.8.0] - 2011-05-03
### Changed
- Renamed from `voteable_mongoid` to `voteable_mongo` (to support other MongoDB ODMs); rake tasks moved from the
  `db:mongoid:voteable` to the `mongo:voteable` namespace; indexes are no longer built in the background.

## [0.7.6] - 2011-05-03
### Changed
- Homepage link.

## [0.7.5] - 2011-05-03
### Changed
- Old vote data fields (`u`, `d`, `uc`, `dc`, `c`, `p`) are unset when migrating; "Voteable" renamed to "Votee" in
  the documentation; announcement of the rename to `voteable_mongo`.

## [0.7.4] - 2011-05-02
### Added
- `Votee#up_voters(VoterClass)`, `Votee#down_voters(VoterClass)`, `Votee#voters(VoterClass)`.
- Voter scopes `Voter.up_voted_for(votee)`, `Voter.down_voted_for(votee)`, `Voter.voted_for(votee)`.
- `voteable ..., :index => true` option.

### Changed
- Faster unvote and revote validations.

### Fixed
- `:up` / `:down` points that are `nil` in the rake tasks.

## [0.7.3] - 2011-04-24
### Added
- `:return_votee => true` option, so that `vote` always returns the votee.
- `Votee#voted?`, `Votee#up_voted?`, `Votee#down_voted?`.

### Changed
- Refactoring.

### Fixed
- The parent is updated for many-to-many relations.

## [0.7.2] - 2011-04-04
### Changed
- `Collection#find_and_modify` returns the updated votes data and `parent_ids`, saving a query.

## [0.7.1] - 2011-04-03
### Added
- `votee#voted_by?(voter or voter_id)`.

### Changed
- Documentation; source code refactored and cleaned up.

## [0.7.0] - 2011-04-02
### Changed
- Readable vote data field names (`up`, `down`, `up_count`, `down_count`, `count`, `point`) instead of the short
  ones (`u`, `d`, `uc`, `dc`, `c`, `p`).

## [0.6.4] - 2011-04-02
### Removed
- `Voter#votees`, `Voter#up_votees`, `Voter#down_votees`, in favour of the `Votee.voted_by(voter)`,
  `Votee.up_voted_by(voter)`, `Votee.down_voted_by(voter)` scopes.

## [0.6.3] - 2011-04-01
### Added
- `rake db:mongoid:voteable:migrate_old_votes`, migrating vote data created by versions before 0.6.0.

## [0.6.2] - 2011-04-01
### Fixed
- Vote data is initialized in `before_create` instead of after initialize.

## [0.6.1] - 2011-03-31
### Added
- `rake db:mongoid:voteable:init_stats`: counters and point set to 0 for voteable objects without vote data, so
  they sort and query correctly.

## [0.6.0] - 2011-03-31
### Added
- `Voter#up_votees`, `Voter#down_votees`.

### Changed
- Smaller vote data (short field names `votes.u`, `votes.d`, `votes.c`, ...).

### Removed
- Indexes and scopes from the statistics module (to be added in the application).

### Fixed
- Bugs in reading vote data.

## [0.5.0] - 2011-03-30
### Changed
- `vote_point` renamed to `voteable`.

## [0.4.5] - 2011-03-30
### Added
- `rake db:mongoid:voteable:remake_stats` in Rails apps (Railtie).

### Changed
- Depends on `mongoid ~> 2.0.0`.

## [0.4.4] - 2011-03-30
### Added
- `up_votes_count`, `down_votes_count`; vote statistics (counters and point) can be regenerated.

## [0.4.3] - 2011-03-30
### Changed
- Vote data wrapped in the `voteable` namespace (`voteable.up_voter_ids`, `voteable.down_voter_ids`,
  `voteable.votes_count`, ...); the gem is managed with Bundler instead of jeweler.

## [0.4.2] - 2011-03-01
### Changed
- Unvote is part of `vote` (`:unvote => true`).

### Fixed
- Polymorphic objects; `up_votes_count` / `down_votes_count` on legacy objects; the parent is only updated when
  the votee was updated.

## [0.4.1] - 2011-02-23
### Added
- Documentation and `README.rdoc`.

## [0.4.0] - 2011-02-23
Released to RubyGems (as `voteable_mongoid`) by upstream. Not tagged here: two commits set the version file to
0.4.0 — on 2010-10-06, after which 0.3.4 was released, and again on 2011-02-23.
### Added
- Unvote: `Voter#unvote`, `Votable#unvote`, `Votable.unvote`.

## [0.3.5] - 2011-02-17
### Changed
- Depends on Mongoid 2.0.0.rc.

## [0.3.4] - 2010-10-06
### Changed
- Updated for the new mongo and bson gems; RSpec 2.0.0.rc.

## [0.3.3] - 2010-09-05
### Added
- Up and down votes counts.

## [0.3.2] - 2010-09-05
### Changed
- Strings instead of classes as hash keys.

## [0.3.1] - 2010-09-05
### Changed
- `vote_point(klass = self, ...)` defaults to the class itself; foreign keys converted to `BSON::ObjectID` when
  needed.

## [0.3.0] - 2010-09-05
### Fixed
- `.classify` before `.constantize`.

## [0.2.3] - 2010-09-03
### Added
- `:new` option to `User#vote`; `Voteable#vote_value(x)` accepts an object, a String or a `BSON::ObjectID`.

### Changed
- Renamed from `votable_mongoid` to `voteable_mongoid` (first published under the new name as 0.2.2); vote values
  converted from String to Symbol.

## [0.2.2] - 2010-09-02
### Added
- Voter interface (`voter.vote(votable, vote_value)`) and validations.

### Changed
- `new_vote(...)` and `update_vote(...)` replaced by `vote(:revote => false / true, ...)`.

## [0.2.1] - 2010-09-01
### Changed
- `voter_ids` arrays are no longer indexed.

## [0.2.0] - 2010-09-01
### Changed
- Options hash instead of an argument list; `_id` Strings converted to `BSON::ObjectID`.

## [0.1.0] - 2010-09-01
### Added
- Initial release by Alex Nguyen (Vinova) as `votable_mongoid`.

[Unreleased]: https://github.com/joe1chen/voteable_mongo/compare/v1.4.0...HEAD
[1.4.0]: https://github.com/joe1chen/voteable_mongo/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/joe1chen/voteable_mongo/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/joe1chen/voteable_mongo/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/joe1chen/voteable_mongo/compare/v1.0.2...v1.1.0
[1.0.2]: https://github.com/joe1chen/voteable_mongo/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/joe1chen/voteable_mongo/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/joe1chen/voteable_mongo/compare/v0.9.3...v1.0.0
[0.9.3]: https://github.com/joe1chen/voteable_mongo/compare/v0.9.2...v0.9.3
[0.9.2]: https://github.com/joe1chen/voteable_mongo/compare/v0.9.1...v0.9.2
[0.9.1]: https://github.com/joe1chen/voteable_mongo/compare/v0.9.0...v0.9.1
[0.9.0]: https://github.com/joe1chen/voteable_mongo/compare/v0.8.1...v0.9.0
[0.8.1]: https://github.com/joe1chen/voteable_mongo/compare/v0.8.0...v0.8.1
[0.8.0]: https://github.com/joe1chen/voteable_mongo/compare/v0.7.6...v0.8.0
[0.7.6]: https://github.com/joe1chen/voteable_mongo/compare/v0.7.5...v0.7.6
[0.7.5]: https://github.com/joe1chen/voteable_mongo/compare/v0.7.4...v0.7.5
[0.7.4]: https://github.com/joe1chen/voteable_mongo/compare/v0.7.3...v0.7.4
[0.7.3]: https://github.com/joe1chen/voteable_mongo/compare/v0.7.2...v0.7.3
[0.7.2]: https://github.com/joe1chen/voteable_mongo/compare/v0.7.1...v0.7.2
[0.7.1]: https://github.com/joe1chen/voteable_mongo/compare/v0.7.0...v0.7.1
[0.7.0]: https://github.com/joe1chen/voteable_mongo/compare/v0.6.4...v0.7.0
[0.6.4]: https://github.com/joe1chen/voteable_mongo/compare/v0.6.3...v0.6.4
[0.6.3]: https://github.com/joe1chen/voteable_mongo/compare/v0.6.2...v0.6.3
[0.6.2]: https://github.com/joe1chen/voteable_mongo/compare/v0.6.1...v0.6.2
[0.6.1]: https://github.com/joe1chen/voteable_mongo/compare/v0.6.0...v0.6.1
[0.6.0]: https://github.com/joe1chen/voteable_mongo/compare/v0.5.0...v0.6.0
[0.5.0]: https://github.com/joe1chen/voteable_mongo/compare/v0.4.5...v0.5.0
[0.4.5]: https://github.com/joe1chen/voteable_mongo/compare/v0.4.4...v0.4.5
[0.4.4]: https://github.com/joe1chen/voteable_mongo/compare/v0.4.3...v0.4.4
[0.4.3]: https://github.com/joe1chen/voteable_mongo/compare/v0.4.2...v0.4.3
[0.4.2]: https://github.com/joe1chen/voteable_mongo/compare/v0.4.1...v0.4.2
[0.4.1]: https://github.com/joe1chen/voteable_mongo/compare/v0.3.5...v0.4.1
[0.3.5]: https://github.com/joe1chen/voteable_mongo/compare/v0.3.4...v0.3.5
[0.3.4]: https://github.com/joe1chen/voteable_mongo/compare/v0.3.3...v0.3.4
[0.3.3]: https://github.com/joe1chen/voteable_mongo/compare/v0.3.2...v0.3.3
[0.3.2]: https://github.com/joe1chen/voteable_mongo/compare/v0.3.1...v0.3.2
[0.3.1]: https://github.com/joe1chen/voteable_mongo/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/joe1chen/voteable_mongo/compare/v0.2.3...v0.3.0
[0.2.3]: https://github.com/joe1chen/voteable_mongo/compare/v0.2.2...v0.2.3
[0.2.2]: https://github.com/joe1chen/voteable_mongo/compare/v0.2.1...v0.2.2
[0.2.1]: https://github.com/joe1chen/voteable_mongo/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/joe1chen/voteable_mongo/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/joe1chen/voteable_mongo/releases/tag/v0.1.0
