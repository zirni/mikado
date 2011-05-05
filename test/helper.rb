require File.expand_path('../../lib/mikado', __FILE__)
require 'rubygems'
require 'bundler/setup'

Bundler.require :test

require 'test/item'

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "test/db/test.sqlite3"
)