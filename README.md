# Rubyhub

Rubyhub allows you to create pull requests faster with all сomponents - labels, assignees, reviewers and other stuff you had to put manually each time.

## Installation

Install [Github's Hub]https://github.com/github/hub

Add this line to your application's Gemfile:

```ruby
gem 'rubyhub'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubyhub

## Usage

1. Generate config file

    $ rubyhub install

2. Create the templates for all subteams/needs in your repository and configure

2. Run pull request creator

    $rubyhub create -t your_template_name

## Configuration options

| base_branch           | String. Define the base branch you Pull Request would be targeted to                                                                                                                                                                                    | develop                              |   |   |
|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------|---|---|
| reviewers             | Array. List of reviewers                                                                                                                                                                                                                                | - some_user - another_user           |   |   |
| assignees             | Array. List of assignees                                                                                                                                                                                                                                | - some_user - another_user           |   |   |
| labels                | Array. List of labels                                                                                                                                                                                                                                   | - needs_review - some_another_label  |   |   |
| jira_base_url         | String. The first line of your Pull Request description could be JIRA link to your task Put here the constant part of your URL. Task name would be taken from your branch name.  feature/MyTask-1399 -> https://sample.atlassian.net/browse/MyTask-1399 | https://sample.atlassian.net/browse/ |   |   |
| description_main_body | String. Put the description template here. We recommended to use Markdown.  Note: The first line of your body - would be a title of your pull-request                                                                                                   | Feature | RGWEB  Great moments!      |   |   |
| push                  | Boolean. These options allows to push the code to Github before creating the pull-request                                                                                                                                                               | true                                 |   |   |
| open                  | Boolean. Open the pull-request after creating                                                                                                                                                                                                           | true                                 |   |   |
