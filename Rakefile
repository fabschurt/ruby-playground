require 'rake/testtask'

SRC_DIR = File.join(File.expand_path(File.dirname(__FILE__)), 'src')

Rake::TestTask.new do |task|
  task.description = 'Run minitest specs'
  task.test_files = FileList[File.join(SRC_DIR, '*.rb')]
end
