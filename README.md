# Rubyhub

Rubyhub allows you to create pull requests faster with all those labels, assignees and reviewers you always had to put manually.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubyhub'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubyhub

## Usage

1. Create `.rubyhub.yml` file with your own properties. Don't forget to add it to gitignore.
Example config:
```yaml
---
  base_branch: master
  label: needs review
  assignees:
    - any
    - github
    - reviewer
    - you
    - want
  description_main_body: describe your changes here
  jira_base_url: https://sample.atlassian.net/browse/
```

`description_main_body` and `jira_base_url` are optional.

2. Run `bin/rubyhub`

