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

end
