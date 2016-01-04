# KawaiiValidation

An ActiveRecord extension that adds more kawaii validation syntax.

## Motivation

The "Sexy Validation" syntax is not at all sexy.

## Installation

Gemfile:

    gem 'kawaii_validation'

And then execute:

    $ bundle

## Supported versions

* Ruby 2.0, 2.1, 2.2, 2.3, and 2.4 (trunk)

* Rails 3.2.x, 4.0, 4.1, 4.2, and 5.0 (edge)

## Usage

With this gem bundled, the `validates` method takes a block argument, and the following two new DSLs will be enabled:

* Original code (so-called "Sexy Validation")

```ruby
class User < ActiveRecord::Base
  # validations begin
  validates :name, :age, presence: true
  validates :name, length: {maximum: 255}
  validates :age, numericality: {greater_than: 0}
  # validations end

  ...
end
```

* validates + block

```ruby
class User < ActiveRecord::Base
  validates do
    presence_of :name, :age
    length_of :name, maximum: 255
    numericality_of :age, greater_than: 0
  end

  ...
end
```

* validates + attributes + block

```ruby
class User < ActiveRecord::Base
  validates :name do
    presence
    length maximum: 255
  end

  validates :age do
    presence
    numericality greater_than: 0
  end

  ...
end
```

## Contributing

* Send me your pull requests!
