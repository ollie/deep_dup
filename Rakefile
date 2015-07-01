require 'bundler/gem_tasks'

task default: :combo

desc 'Run tests, rubocop and generate documentation'
task :combo do
  sh 'bundle exec rspec'
  sh('bundle exec rubocop') {} # ignore status > 0
  sh 'bundle exec yardoc'
end

desc 'Same as :combo but build a gem, too'
task mega_combo: :combo do
  sh 'gem build deep_dup.gemspec'
end
