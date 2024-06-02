class CreateMealPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :meal_plans do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :diet
      t.integer :calorie_target
      t.integer :num_meals

      t.timestamps
    end
  end
end
