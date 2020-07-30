class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name,              null: false
      t.integer :price,             null: false
      t.integer :currency,          null: false, default: 0
      t.integer :type_of_course,    null: false, default: 0
      t.boolean :public,            null: false, default: true
      t.text :description
      t.text :url
      t.datetime :valididy_period,  null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
