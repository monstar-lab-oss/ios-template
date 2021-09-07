source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'cocoapods'
gem 'fastlane'
gem 'xcpretty'
gem 'danger'
gem 'danger-swiftlint'
gem 'fastlane-plugin-firebase_app_distribution'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)