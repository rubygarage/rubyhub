require 'pry'
require 'rubyhub/pull_requests_pusher'

module Rubyhub
  def self.run
    PullRequestsPusher.call
  end
end
