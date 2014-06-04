# Anvil

Anvil is a tool for the real craftsmen to build its own tools.

[![Build Status](https://travis-ci.org/anvil-src/anvil-core.png?branch=master)](https://travis-ci.org/anvil-src/anvil-core)
[![Gem Version](https://badge.fury.io/rb/anvil-core.svg)](http://badge.fury.io/rb/anvil-core)
[![Code Climate](https://codeclimate.com/github/anvil-src/anvil-core.png)](https://codeclimate.com/github/anvil-src/anvil-core)
[![Coverage](https://codeclimate.com/github/anvil-src/anvil-core/coverage.png)](https://codeclimate.com/github/anvil-src/anvil-core)

Anvil tries to be a framework for building command line applications
to automate tedious tasks like apps or gems releasing process. Pull
request updating, etc.

It's purpose is to provide an easy to use Object Oriented toolset
that developers can use to automate par of its day to day work.

Things like:

  * Updating your pull requests.
  * Installing your dot files
  * Doing complex build which involve several projects and branches.
  * Any other stuff you might want.

## Sample tasks

You can find some sample tasks in the samples directory, if you want to give them a try, clone this project and do:

```shell
ANVIL_EXTENSIONS_DIR=./sample bin/anvil
```

## Installation

To install it:

    gem install anvil-core

## Usage

To see all the options execute:

    $ anvil

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add tests for your new feature
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
7. Make sure your tests are passing on all the rubies!
