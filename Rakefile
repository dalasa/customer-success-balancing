#!/usr/bin/env rake
# frozen_string_literal: true

require 'rake/testtask'

desc 'Roda os testes'
task :test do
  Rake::TestTask.new do |t|
    t.test_files = FileList['tests/**/*_test.rb', 'tests/customer_success_balancing.rb']
  end
end
