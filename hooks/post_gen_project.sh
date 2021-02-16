#!/bin/sh

set -e

# Initialize Git
git init

# Install required gems
bundle install --path vendor/bundle

# Install pods
bundle exec pod install

