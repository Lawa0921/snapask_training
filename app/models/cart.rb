class Cart
  attr_reader :courses, :add_success

  def initialize(courses = [])
    @courses = courses
  end

  def add_course(course)
    if @courses.include?(course)
      @add_success = false
    else
      @add_success = true
      @courses << course
    end
  end

  def self.from_hash(hash = nil )
    if hash && hash["courses"]
      @courses = []
      hash["courses"].each do |course|
        @courses << Course.find(course["id"])
      end 
      new(@courses)
    else
      new
    end
  end

  def to_hash
    courses = @courses.map { |course|  
      { "id" => course.id } 
    }

    return { "courses" => courses }
  end

  def empty?
    courses.blank?
  end

end
