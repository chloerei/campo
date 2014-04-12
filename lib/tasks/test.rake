namespace :test do
  Rails::TestTask.new(:jobs => 'test:prepare') do |t|
    t.pattern = 'test/jobs/**/*_test.rb'
  end
end

Rake::Task[:test].enhance { Rake::Task["test:jobs"].invoke }
