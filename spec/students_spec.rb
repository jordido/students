require_relative '../students'

	describe "Checking with ActiveRecord" do	
		before do
	    @student = Student.new
	    @student.name = 'Joe'
	    @student.surnames = 'Ironhack'
	    @student.birthday = 20.years.ago
	    @student.number_of_dogs = 1
	    @student.website = 'http://ironhack.com'
		end
		it "checks if an empty name is returning invalid" do
			@student.name = ""
			expect(@student.valid?).to eq (false)
		end
		it "checks if an empty surname is returning invalid" do
			@student.surnames = ""
			expect(@student.valid?).to eq (false)
		end
		it "if we have an 11 year old student we won’t accept him (yet)" do
			@student.birthday = Date.new(2005,12,10)
			expect(@student.valid?).to eq (false)
		end
		it "checks that complete.name == name + surnames" do
			@student.name = "perico"
			@student.surnames ="de los palotes"
			expect(@student.complete_name).to eq "perico de los palotes"
		end
		it "won’t accept students born before 1970 that have more than one dog" do
			@student.name = 'Joe'
	    @student.surnames = 'Ironhack'
			@student.birthday = 45.years.ago
			@student.number_of_dogs = 2
			expect(@student.valid?).to eq (false)
		end
		it "won’t accept students which have Xavier name" do
			@student.name = "Xavier"
			expect(@student.valid?).to eq (false)
		end
		it "won’t accept students which have Jordi name" do
			@student.name = "Jordi"
			expect(@student.valid?).to eq (false)
		end
	end
	describe "Checking with our own DSL method" do
		before do
    @student = Student.new
    @student.name = 'Joe'
    @student.surnames = 'Ironhack'
    @student.birthday = 20.years.ago
    @student.number_of_dogs = 1
    @student.website = 'http://ironhack.com'
		end
		it "checks if an empty name is returning invalid" do
				@student.name = ""
				expect(@student.presence_of_name?).to eq (false)
		end
		it "if we have an 11 year old student we won’t accept him (yet)" do
			@student.birthday = Date.new(2005,12,10)
			expect(@student.younger_than?(11)).to eq (false)
		end
	end