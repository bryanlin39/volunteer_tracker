require('rspec')
require('pg')
require('project')
require('pry')

DB = PG.connect({:dbname => 'volunteer_tracker_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM projects *;")
  end
end

describe(Project) do

  
end
