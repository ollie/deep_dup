require 'bundler/setup'

require 'simplecov'

# Coverage tool, needs to be started as soon as possible
SimpleCov.start do
  add_filter '/spec/' # Ignore spec directory
end

require 'deep_dup'
require 'bigdecimal'
