# Paragraphify

Takes a long string and inserts spaces and newlines to convert into a paragraph format.

### Examples:
Given the input string
```Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vitae semper quis lectus nulla at volutpat diam ut venenatis. Sollicitudin nibh sit amet commodo nulla facilisi```
and the following settings:
- `Pragraphify::Paragraph.new()` - defaults of `linebreak = 80`, `leading_indent = 0`, `hanging_indent = 0`
  - `Paragraphify::paragraphify() will return
```
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Vitae semper quis lectus nulla at
volutpat diam ut venenatis. Sollicitudin nibh sit amet commodo nulla facilisi
```
- `Pragraphify::Paragraph.new(hanging_indent: 8)` - defaults of `linebreak = 80`, `leading_indent = 0`
  - `Paragraphify::paragraphify() will return
```
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
        incididunt ut labore et dolore magna aliqua. Vitae semper quis lectus
        nulla at volutpat diam ut venenatis. Sollicitudin nibh sit amet commodo
        nulla facilisi
```
- `Pragraphify::Paragraph.new(leading_indent: 4)` - defaults of `linebreak = 80`, `hanging_indent = 0`
  - `Paragraphify::paragraphify() will return
```
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Vitae semper quis lectus
nulla at volutpat diam ut venenatis. Sollicitudin nibh sit amet commodo nulla
facilisi
```
- `Pragraphify::Paragraph.new(leading_indent: 4, hanging_indent: 8)` - default of `linebreak = 80`
  - `Paragraphify::paragraphify() will return
```
    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Vitae semper quis
        lectus nulla at volutpat diam ut venenatis. Sollicitudin nibh sit amet
        commodo nulla facilisi
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'paragraphify'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install paragraphify

## Usage

- Initialize module using `Paragraphify::Paragraph.new()` which any of the following optional keyword arguments:
  - `linebreak:` (default = 80) - where the text will be broken with a newline character, keeping words intact.
  - `leading_indent:` (default = 0) - inserts this number of spaces at the start of the returned string.
  - `hanging_indent:` (default = 0) - inserts this number of spaces after each newline inserted.

- Call conversion method using `Paragraphify#paragraphify()` with a single mandatory keyword argument `string:`, returns a string formatted per the settings of the calling instance.

- Setters & getters for
  - `Paragraphify#linebreak`
  - `Paragraphify#leading_indent`
  - `Paragraphify#hanging_indent`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mkevinosullivan/paragraphify.
