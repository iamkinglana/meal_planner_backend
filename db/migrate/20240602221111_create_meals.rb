class CreateMeals < ActiveRecord::Migration[7.1]
  def change
    create_table :meals do |t|
      t.references :meal_plan, null: false, foreign_key: true
      t.string :name
      t.integer :calories
      t.text :ingredients

      t.timestamps
    end
  end
end
