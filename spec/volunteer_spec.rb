require('rspec')
require('pg')
require('volunteer')
require('pry')

DB = PG.connect({:dbname => 'volunteer_tracker_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM volunteers *;")
  end
end

describe(Volunteer) do


end
