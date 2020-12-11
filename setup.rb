#! /usr/bin/env ruby

class Setup
  def initialize
    @options = {
      help: false,
      bundle: true,
    }

    ARGV.each do |arg|
      case arg
      when "-h", "--help"
        @options[:help] = true
      when "--no-bundle"
        @options[:bundle] = false
      end
    end
  end

  def run
    return show_help if @options[:help]

    bundle_gems if @options[:bundle]

    install_yarn

    db_setup
  end

  def bundle_gems
    puts "Bundling gems"
    # assuming you already have bundle
    system "bundle install"
  end

  def db_setup
    system "rails db:create db:migrate"
  end

  def install_yarn
    system "yarn install"
  end

  private

  def show_help
    help_content = <<~ENDHELP
    Usage:
      setup.rb [-h|--help] [--bundle|--bundler]
​         -h, --help       Show this help.
       --no-bundle      Skip bundle install
    ENDHELP

    puts help_content
  end
end

Setup.new.run if $0 == __FILE__
