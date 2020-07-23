class CoursesController < ApplicationController
  before_action :set_course, only: [:edit, :update]

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.user = current_user
    if @course.save
      redirect_to courses_path, notice: t('courses.created')
    else
      flash[:notice] = t('courses.create_fail')
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to courses_path, notice: t('courses.update')
    else
      flash[:notice] = t('courses.fail')
      render :edit
    end
  end

  private
  def course_params
    params.require(:course).permit(:name, :description, :price, :currency, :type_of_course, :public, :url, :valididy_period)
  end

  def set_course
    @course = current_user.courses.find(params[:id])
  end
end
