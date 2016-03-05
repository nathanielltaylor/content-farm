class Titles < ActiveRecord::Migration
  def change
    create_table :titles do |t|
      t.string :title, null: false
      t.timestamps
    end
  end
end
