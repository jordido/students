require 'rubygems'
require 'active_record'
require 'date'
require "pry"

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'students.sqlite'
)

class Student < ActiveRecord::Base
  # we have name, surnames, birthday, website, number_of_dogs
  # and first_programming_experience

  AGE_MINIMUM = 16

  validates_presence_of :name, :surnames
  validates_format_of :website, with: /\Ahttp:/
  validates_numericality_of :number_of_dogs, greater_than: 0
  validate :proper_age
  validate :old_and_many_dogs
  validates_exclusion_of :name, :in => %w(Xavier Jordi)

  def complete_name
    name + " " + surnames
  end

  def presence_of_name?
    unless name == ""
      true
    else
      false
    end
  end
  
  def younger_than? (age)
    unless birthday < age.years.ago
      false
    else
      true
    end
  end

  private

  def proper_age
    unless birthday < AGE_MINIMUM.years.ago
      errors.add(:birthday, 'is too young')
    end
  end

  def old_and_many_dogs
    if (birthday.year < 1970) && (number_of_dogs > 1)
      errors.add(:birthday, 'too old for so many dogs')
    end
  end

end




__END__