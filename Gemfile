source 'https://rubygems.org' do
    gem 'bundler'
    gem 'fastlane'
    gem 'cocoapods'
    gem 'xcpretty'
    gem 'slather'
end

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)