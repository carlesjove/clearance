rails_versions = %w(
  4.2
  5.0
  5.1
  5.2
)

rails_versions.each do |version|
  appraise "rails_#{version}" do
    gem "railties", "~> #{version}.0"
    if Gem::Version.new(version) >= Gem::Version.new("5.0")
      gem "rails-controller-testing"
    end
    gem 'sqlite3', '~> 1.3.13'

    gem 'rspec-rails', '~> 3.1'
    gem 'shoulda-matchers', '~> 4.0'
  end
end

# Rails 6 pre-release testing
# Combine with above when 6.0 is final
appraise "rails_6.0" do
  gem "railties", "~> 6.0.0.rc1"
  gem "rails-controller-testing"
  gem 'sqlite3', '~> 1.4.0'

  # TODO - Switch to 4.0 gem or pre-release
  gem 'rspec-rails', github: "rspec/rspec-rails", branch: "4-0-dev"
  gem 'rspec-core', github: "rspec/rspec-core"
  gem 'rspec-mocks', github: "rspec/rspec-mocks"
  gem 'rspec-expectations', github: "rspec/rspec-expectations"
  gem 'rspec-support', github: "rspec/rspec-support"

  # TODO - Once release is out, switch away from github
  gem 'shoulda-matchers', github: "thoughtbot/shoulda-matchers"
end
