require 'rake/testtask'

SRC_DIR = File.join(File.expand_path(File.dirname(__FILE__)), 'src')

task default: :test

Rake::TestTask.new do |task|
  task.description = 'Run minitest specs'
  task.test_files = FileList[File.join(SRC_DIR, '*.rb')]
  task.libs << SRC_DIR
  task.verbose = true
end
