# DeepDup [![Build Status](https://img.shields.io/travis/ollie/deep_dup/master.svg)](https://travis-ci.org/ollie/deep_dup) [![Code Climate](https://img.shields.io/codeclimate/github/ollie/deep_dup.svg)](https://codeclimate.com/github/ollie/deep_dup) [![Gem Version](https://img.shields.io/gem/v/deep_dup.svg)](https://rubygems.org/gems/deep_dup)

Deep duplicate Ruby objects. Some objects cannot be `dup`ped like `nil`,
`false`, `true`, numbers, symbols and method objects. In those cases
return themselves.

## Usage

No monkey patching:

```ruby
dupped = DeepDup.deep_dup('chunky')
dupped = DeepDup.deep_dup(['chunky', [:bacon, { hi: 5 }]])
dupped = DeepDup.deep_dup(['a', :a, 1, { bacon: { chunky: 'yeah' } }])
dupped = DeepDup.deep_dup(SomeClass.new)

array = [1, 2]
array << array
dupped = DeepDup.deep_dup(array)
```

With monkey patching

```ruby
require 'deep_dup/core_ext/object'

dupped = 'chunky'.deep_dup
dupped = ['chunky', [:bacon, { hi: 5 }]].deep_dup
dupped = ['a', :a, 1, { bacon: { chunky: 'yeah' } }].deep_dup
dupped = SomeClass.new.deep_dup

array = [1, 2]
array << array
dupped = array.deep_dup
```
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'deep_dup'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install deep_dup

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ollie/deep_dup.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Credits

Thanks [Ice Nine](https://github.com/dkubb/ice_nine) and [Rails](https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/object/duplicable.rb) for inspiration.
