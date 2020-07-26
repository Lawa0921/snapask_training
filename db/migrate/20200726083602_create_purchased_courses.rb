class CreatePurchasedCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :purchased_courses do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
      t.datetime :expirt_date

      t.timestamps
    end
  end
end
