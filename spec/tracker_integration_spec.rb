require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new project', {:type => :feature}) do
  it('allows a user to enter a new project in the form and see it displayed in the list of projects') do
    visit('/projects')
    fill_in('description', :with =>'Food drive')
    click_button('Add Project')
    expect(page).to have_content('Food drive')
  end
end
