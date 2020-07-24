class ChangeCourseColumnValididyPeriod < ActiveRecord::Migration[5.2]
  def up
    remove_column :courses, :valididy_period
    add_column :courses, :valididy_period, :integer, null: false, default: 1
  end
  def down
    remove_column :courses, :valididy_period
    add_column :courses, :valididy_period, :datetime, null: false, default: DateTime.current
  end
end
