require 'rake/testtask'

SPEC_DIR = File.join(File.expand_path(File.dirname(__FILE__)), 'spec')

Rake::TestTask.new do |task|
  task.description = 'Run minitest specs'
  task.test_files = FileList[File.join(SPEC_DIR, '*.rb')]
end
