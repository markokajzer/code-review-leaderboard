# Code Review Leaderboard

Create a leaderboard of code reviewers for your repository or organization.

Find out who is the most active reviewer in your team, who is the most thorough, and who is the most critical.

## Examples

<img width="762" alt="Screenshot 2024-02-10 at 20 57 55" src="https://github.com/markokajzer/code-review-leaderboard/assets/9379317/dcd84512-1372-4744-a45f-b9b076fcf6b7">

> [!NOTE]
> For a repository of 719 repositories and 529 reviews, the script takes roughly 1 minute.

Reviews are counted by the following rules:
1. Completed within the last 30 days
2. Multiple comments only count once.
3. If a reviewer both approves/rejects a pull request _and_ comments, the comments do not count extra.
4. Approvals and rejections always count.

## Installation

Install the gem:

    $ gem install code_review_leaderboard

## Usage

To use the gem, you will need to provide a GitHub access token. You can create a new access token by following the instructions [here](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line). If you want to inspect the repositories of an organization, make sure the organization in question allows access to their repositories from personal access tokens. You can check that from `https://github.com/organizations/<name>/settings/personal-access-tokens`.

To inspect the reviews of a single repository, run:

    $ code_review_leaderboard --access_token ACCESS_TOKEN --repository REPOSITORY

You can also provide multiple repositories:

    $ code_review_leaderboard --access_token ACCESS_TOKEN --repository REPOSITORY1 REPOSITORY2

Finally, you can also inspect the repositories of an organization:

    $ code_review_leaderboard --access_token ACCESS_TOKEN --organization ORGANIZATION

## Configuration

You can either configure the gem via command line arguments or by setting environment variables. Command line arguments take precedence.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. You can then run it with `bundle exec <executable>`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/markokajzer/code-review-leaderboard.
