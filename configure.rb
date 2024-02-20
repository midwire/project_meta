#!/usr/bin/env ruby
# frozen_string_literal: true

# Configure docs:
#
# Configure a new project with the templates in this directory.

require 'optimist'
require 'fileutils'
require 'colored'
require 'erb'
require 'active_support/all'
require 'pry'

class Configure
  include FileUtils
  attr_accessor :file_count, :options, :elapsed

  class ReplaceableTags
    attr_accessor :project_new_issue_url, :project_issues_url, :project_home_url, :project_name,
      :project_name_titleized

    def initialize(project_name)
      self.project_name = project_name
      self.project_name_titleized = project_name.titleize
      self.project_home_url = "https://github.com/midwire/#{project_name}"
      self.project_new_issue_url = "#{project_home_url}/issues/new"
      self.project_issues_url = "#{project_home_url}/issues"
    end
  end

  class << self
    def collect_args(*_args)
      Optimist.options do
        opt(
          :project_name,
          'GitHub project name',
          type: :string, short: 'n', required: true
        )
        opt(
          :project_path,
          'Path to the new project',
          type: :string, short: 'p', required: true
        )

        opt(
          :rubocop,
          'Copy the .rubocop.yml template',
          type: :boolean, short: 'r', required: false, default: true
        )
        opt(
          :verbose,
          'Be verbose with the output',
          type: :boolean, short: 'v', required: false, default: false
        )
        opt(
          :color,
          'Use colored output',
          type: :boolean, short: 'c', required: false, default: true
        )
      end
    end

    def run
      start_time = Time.now
      opts = collect_args(ARGV)

      instance = Configure.new(opts)
      instance.process
      instance.elapsed = Time.now - start_time
      instance.report_summary
    end
  end

  def initialize(opts)
    self.file_count    = 0
    self.options       = opts
  end

  def color(string, clr)
    if options[:color]
      puts(string.send(clr))
    else
      puts(string)
    end
  end

  def report_summary
    puts
    color(">>> Processed #{file_count.to_i} files in [#{elapsed}] seconds", :red)
  end

  def process
    Dir.glob(File.join(root, '*.md')) do |template|
      next if %w[README.md].include? File.basename(template)

      output_file = File.join(options[:project_path], File.basename(template))
      puts(">>> Processing #{output_file}")
      contents = File.read(template)
      @tags = ReplaceableTags.new(options[:project_name])
      html = ERB.new(contents).result(binding)
      File.write(output_file, html)
    end
    # Also copy the .rubocop.yml file
    return unless options[:rubocop]

    FileUtils.cp(File.join(root, '.rubocop.yml'), File.join(options[:project_path], '.rubocop.yml'))
  end

  private

  def root
    File.dirname(__FILE__)
  end
end

Configure.run
