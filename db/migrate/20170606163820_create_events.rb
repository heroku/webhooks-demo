class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.jsonb :payload, null: false
      t.timestamps
    end
  end
end
