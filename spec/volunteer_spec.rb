require('spec_helper')

describe(Volunteer) do
  describe('#==') do
    it('is the same volunteer if it has the same name and hours and list_id') do
      volunteer1 = Volunteer.new({:id => nil, :name => 'Bob', :hours => 8, :project_id => 1})
      volunteer2 = Volunteer.new({:id => nil, :name => 'Bob', :hours => 8, :project_id => 1})
      expect(volunteer1).to eq(volunteer2)
    end
  end

  describe('#name') do
    it('returns the name of the volunteer') do
      volunteer1 = Volunteer.new({:id => nil, :name => 'Bob', :hours => 8, :project_id => 1})
      expect(volunteer1.name()).to eq('Bob')
    end
  end

  describe('#hours') do
    it('returns the number of hours the volunteer worked') do
      volunteer1 = Volunteer.new({:id => nil, :name => 'Bob', :hours => 8, :project_id => 1})
      expect(volunteer1.hours()).to eq(8)
    end
  end

  describe('.all') do
    it('returns all the volunteers in the database') do
      volunteer1 = Volunteer.new({:id => nil, :name => 'Bob', :hours => 8, :project_id => 1})
      volunteer1.save()
      expect(Volunteer.all()).to eq([volunteer1])
    end
  end

  describe('#save') do
    it('adds a volunteer to the database') do
      volunteer1 = Volunteer.new({:id => nil, :name => 'Bob', :hours => 8, :project_id => 1})
      volunteer1.save()
      expect(Volunteer.all()).to eq([volunteer1])
    end
  end

end
