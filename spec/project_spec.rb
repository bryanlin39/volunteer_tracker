require('spec_helper')

describe(Project) do
  describe('#==') do
    it('is the same project if it has the same description') do
      project1 = Project.new({:id => nil, :description => 'food drive'})
      project2 = Project.new({:id => nil, :description => 'food drive'})
      expect(project1).to eq(project2)
    end
  end

  describe('#description') do
    it('returns the description of the project') do
      project1 = Project.new({:id => nil, :description => 'food drive'})
      expect(project1.description()).to eq('food drive')
    end
  end

  describe('.all') do
    it('returns all the projects in the database') do
      project1 = Project.new({:id => nil, :description => 'food drive'})
      project1.save()
      expect(Project.all()).to eq([project1])
    end
  end

  describe('#save') do
    it('adds a project to the database') do
      project1 = Project.new({:id => nil, :description => 'food drive'})
      project1.save()
      expect(Project.all()).to eq([project1])
    end
  end

  describe('.find') do
    it('returns a project based on its id') do
      project1 = Project.new({:id => nil, :description => 'food drive'})
      project1.save()
      project2 = Project.new({:id => nil, :description => 'freeway cleanup'})
      project2.save()
      expect(Project.find(project2.id())).to eq(project2)
    end
  end

  describe('#volunteers') do
    it('returns the volunteers working on the project') do
      project1 = Project.new({:id => nil, :description => 'food drive'})
      project1.save()
      volunteer1 = Volunteer.new({:id => nil, :name => 'Bob', :hours => 8, :project_id => project1.id()})
      volunteer1.save()
      expect(project1.volunteers()).to eq([volunteer1])
    end
  end

end
