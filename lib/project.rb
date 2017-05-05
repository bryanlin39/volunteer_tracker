class Project
  attr_accessor(:id, :description)

  def initialize(attributes)
    @id = attributes[:id]
    @description = attributes[:description]
  end

  def ==(other)
    self.id() == other.id() && self.description() == other.description()
  end

  def self.all
    database_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    database_projects.each() do |project|
      description = project['description']
      id = project['id'].to_i()
      projects.push(Project.new({:id => id, :description => description}))
    end
    projects
  end

  def save
    result = DB.exec("INSERT INTO projects (description) VALUES ('#{@description}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  def self.find(id)
    found_project = nil
    Project.all().each() do |project|
      if project.id() == id.to_i()
        found_project = project
      end
    end
    found_project
  end

  def volunteers
    project_volunteers = []
    volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id()};")
    volunteers.each() do |volunteer|
      id = volunteer['id'].to_i()
      name = volunteer['name']
      hours = volunteer['hours'].to_i()
      project_id = volunteer['project_id'].to_i()
      project_volunteers.push(Volunteer.new({:id => id, :name => name, :hours => hours, :project_id => project_id}))
    end
    project_volunteers
  end

  def update(attributes)
    @id = self.id()
    @description = attributes.fetch(:description, @description)
    DB.exec("UPDATE projects SET description = '#{@description}' WHERE id = #{@id};")
  end

end
