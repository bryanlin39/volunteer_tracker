require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/project')
require('./lib/volunteer')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'volunteer_tracker'})

get('/') do
  erb(:index)
end

get('/projects') do
  @projects = Project.all()
  erb(:projects)
end

post('/projects/new') do
  description = params[:description]
  @project = Project.new({:id => nil, :description => description})
  @project.save()
  @projects = Project.all()
  erb(:projects)
end

get('/projects/:id') do
  project_id = params['id']
  @project = Project.find(project_id)
  erb(:project)
end

post('/projects/new_volunteer') do
  project_id = params['project_id'].to_i()
  @project = Project.find(project_id)
  name = params[:name]
  @volunteer = Volunteer.new({:id => nil, :name => name, :hours => 0, :project_id => project_id})
  @volunteer.save()
  @projects = Project.all()
  erb(:project)
end

patch('/projects/:id/edit') do
  project_id = params['id'].to_i()
  @project = Project.find(project_id)
  description = params['description']
  @project.update({:description => description})
  erb(:project)
end

delete('/projects/:id/delete') do
  project_id = params['id'].to_i()
  @project = Project.find(project_id)
  @project.delete()
  @projects = Project.all()
  erb(:projects)
end

get('/volunteers') do
  @volunteers = Volunteer.all()
  erb(:volunteers)
end

get('/volunteers/:id') do
  volunteer_id = params['id']
  @volunteer = Volunteer.find(volunteer_id)
  erb(:volunteer)
end
