class AddColumnToPuchasedCourses < ActiveRecord::Migration[5.2]
  def change
    add_column :purchased_courses, :currency, :integer
    add_column :purchased_courses, :price, :integer
  end
end
