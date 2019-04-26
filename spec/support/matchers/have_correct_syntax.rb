# TODO - the `ammeter` gem appears to be unmaintained.
# This file is taken from:
# https://github.com/alexrothenberg/ammeter/blob/v1.1.4/lib/ammeter/rspec/generator/matchers/have_correct_syntax.rb
# The code below has changes to the `check_erb_syntax` method,
# explained near the changes.

RSpec::Matchers.define :have_correct_syntax do
  match do |file_path|
    source = File.read(file_path)
    extension = File.extname(file_path)
    case extension
      when '.rb', '.rake'
        check_ruby_syntax(source)
      when '.rhtml', '.erb'
        check_erb_syntax(source)
      when '.haml'
        check_haml_syntax(source)
      else
        raise "Checking syntax for #{extension} files is not yet supported"
    end

  end

  define_method :check_ruby_syntax do |code|
    begin
      eval('__crash_me__;' + code)
    rescue SyntaxError
      false
    rescue NameError
      true
    end
  end

  define_method :check_erb_syntax do |code|
    require 'action_view'
    require 'ostruct'

    # The next few lines monkey patch the gem method to allow for rails
    # versions 6 and over, which changed this method.
    view = if Rails::VERSION::MAJOR >= 6
      ActionView::Template::Handlers::ERB.call(OpenStruct.new, code)
    else
      ActionView::Template::Handlers::ERB.call(OpenStruct.new(:source => code))
    end

    begin
      eval('__crash_me__; ' + view)
    rescue SyntaxError
      false
    rescue NameError
      true
    end
  end

  define_method :check_haml_syntax do |code|
    require 'haml'

    begin
      Haml::Engine.new(code)
    rescue Haml::SyntaxError
      false
    rescue NameError
      true
    end
  end

end
