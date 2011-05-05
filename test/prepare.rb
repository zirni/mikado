require File.expand_path('../helper', __FILE__)

ActiveRecord::Migration.create_table :items do |t|
  t.string :title
  t.string :description
end
