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
  
end
