class Volunteer
  attr_accessor(:id, :name, :hours, :project_id)

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @hours = attributes[:hours]
    @project_id = attributes[:project_id]
  end

  def ==(other)
    self.id() == other.id() && self.name() == other.name() && self.hours() == other.hours() && self.project_id() == other.project_id()
  end

  def self.all
    database_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    database_volunteers.each() do |volunteer|
      name = volunteer['name']
      hours = volunteer['hours'].to_i()
      id = volunteer['id'].to_i()
      project_id = volunteer['project_id'].to_i()
      volunteers.push(Volunteer.new({:id => id, :name => name, :hours => hours, :project_id => project_id}))
    end
    volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, hours, project_id) VALUES ('#{@name}', #{@hours}, #{@project_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  def self.find(id)
    found_volunteer = nil
    Volunteer.all().each() do |volunteer|
      if volunteer.id() == id.to_i()
        found_volunteer = volunteer
      end
    end
    found_volunteer
  end

  def project
    project = DB.exec("SELECT * FROM projects WHERE id = #{self.project_id()}")
    id = project.first().fetch('id').to_i()
    description = project.first().fetch('description')
    assigned_project = Project.new({:id => id, :description => description})
    assigned_project.description()
  end

  def update(attributes)
    @id = self.id()
    @name = attributes.fetch(:name, @name)
    @hours = attributes.fetch(:hours, @hours).to_i()
    @project_id = attributes.fetch(:project_id, @project_id).to_i()
    DB.exec("UPDATE volunteers SET (name, hours, project_id) = ('#{@name}', #{@hours}, #{@project_id}) WHERE id = #{@id};")
  end

end
