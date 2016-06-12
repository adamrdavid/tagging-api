class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :entity_id
      t.string :entity_type

      t.timestamps null: false
    end
  end
end
