class Cart
  attr_reader :courses, :add_success

  def initialize(courses = [])
    @courses = courses
  end

  def add_course(course)
    count = courses.count
    @courses << course unless @courses.include?(course)
    courses.count > count ? @add_success = true : @add_success = false
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
      { "id" => course.id } 
    }

    return { "courses" => courses }
  end

  def empty?
    courses.blank?
  end

end
