class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.json :event
      t.timestamps
    end
  end
end
