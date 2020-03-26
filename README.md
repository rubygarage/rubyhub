# Rubyhub

Rubyhub allows you to create pull requests faster with all сomponents - labels, assignees, reviewers and other stuff you had to put manually each time.

## Installation

Install [Github's Hub](https://github.com/github/hub)

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

    `$ rubyhub init`

2. Create the templates for all subteams/needs in your repository and configure each template with provided options

2. Run pull request creator

    `$ rubyhub create -t your_template_name`

## Configuration options
| Config                | Description                                                                                                                                                                                                                                                         | Example                                |
|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------|
| base_branch           | String. Define the base branch you Pull Request would be targeted to                                                                                                                                                                                                | develop                                |
| reviewers             | Array. List of reviewers                                                                                                                                                                                                                                            | - some_user<br>- another_user          |
| assignees             | Array. List of assignees                                                                                                                                                                                                                                            | - some_user<br>- another_user          |
| labels                | Array. List of labels                                                                                                                                                                                                                                               | - needs_review<br>- some_another_label |
| jira_base_url         | String. The first line of your Pull Request description could be JIRA link to your task<br>Put here the constant part of your URL.<br>Task name would be taken from your branch name.<br><br>feature/MyTask-1399 -> https://sample.atlassian.net/browse/MyTask-1399 | https://sample.atlassian.net/browse/   |
| description_main_body | String. Put the description template here. We recommended to use Markdown.<br><br>Note: The first line of your body - would be a title of your pull-request                                                                                                         | Feature / RGWEB<br><br>Great moments!  |
| push                  | Boolean. These options allows to push the code to Github before creating the pull-request                                                                                                                                                                           | true                                   |
| open                  | Boolean. Open the pull-request after creating                                                                                                                                                                                                                       | true                                   |


---
<a href="https://rubygarage.org/"><img src="https://rubygarage.s3.amazonaws.com/assets/assets/rg_color_logo_horizontal-919afc51a81d2e40cb6a0b43ee832e3fcd49669d06785156d2d16fd0d799f89e.png" alt="RubyGarage Logo" width="415" height="128"></a>

RubyGarage is a leading software development and consulting company in Eastern Europe. Our main expertise includes Ruby and Ruby on Rails, but we successfully employ other technologies to deliver the best results to our clients. [Check out our portfolio](https://rubygarage.org/portfolio) for even more exciting works!
