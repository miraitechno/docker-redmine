#!/bin/sh

set -eux

bundle exec rake generate_secret_token
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production bundle exec rake redmine:plugins:migrate
RAILS_ENV=production bundle exec rake redmine:load_default_data
RAILS_ENV=production bundle exec rake redmine:backlogs:install story_trackers=Story task_tracker=Task
bundle exec unicorn -E production -c config/unicorn.rb

