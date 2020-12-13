source 'https://rubygems.org' do
    gem 'danger'
    gem 'bundler'
    gem 'fastlane'
    gem 'cocoapods'
    gem 'xcpretty'
    gem 'slather'
    gem 'openssl'
    gem 'pry'
end

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)