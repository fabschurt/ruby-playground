require 'rake/testtask'

SRC_DIR = File.join(File.expand_path(File.dirname(__FILE__)), 'src')

desc 'Run the :test task'
task default: :test

Rake::TestTask.new do |task|
  task.description = 'Run minitest specs'
  task.test_files = FileList[File.join(SRC_DIR, '*.rb')]
end
