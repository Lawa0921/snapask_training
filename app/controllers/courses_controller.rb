class CoursesController < ApplicationController
  before_action :set_course, only: [:edit, :update, :show, :destroy]
  before_action :check_user_role, except: [:show]

  def index
    current_user.admin? ? @courses = Course.all : @courses = current_user.courses
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

  def show
  end

  def destroy
    if @course.destroy
      flash[:notice] = t('courses.delete')
    else
      flash[:notice] = t('courses.delete_fail')
    end
    redirect_to courses_path
  end

  private
  def course_params
    params.require(:course).permit(:name, :description, :price, :currency, :type_of_course, :public, :url, :valididy_period)
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def check_user_role
    redirect_to root_path, notice: t("users.check_role") if current_user.member?
  end
end
