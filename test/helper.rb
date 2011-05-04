require File.expand_path('../../lib/mikado', __FILE__)
require 'sqlite3'
require 'test/unit'
require 'test/item'

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "test/db/test.sqlite3"
)