class Cart
  attr_reader :courses

  def initialize(courses = [])
    @courses = courses
  end

  def add_course(course)
    found_course = @courses.find {|course| course.id == course.id}
    @courses << course if found_course.blank?
  end

  def self.from_hash(hash = nil)
    if hash && hash["courses"]
      course_data = hash["courses"]
      @courses = []
      course_data.each do |course|
        @courses << Course.find(course["id"])
      end 
      new(@courses)
    else
      new
    end
  end

  def to_hash
    courses = @courses.map { |course|  
      { "price" => course.price, "name" => course.name, "id" => course.id } 
    }

    return { "courses" => courses }
  end

  def empty?
    courses.blank?
  end

end
