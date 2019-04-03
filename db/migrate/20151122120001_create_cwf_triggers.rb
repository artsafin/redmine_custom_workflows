class CreateCwfTriggers < ActiveRecord::Migration[5.2]
  def change
    create_table :cwf_triggers do |t|
      t.integer :cwf_id
      t.string :title, limit: 1000
      t.string :position
      t.string :css_classes
    end
  end
end
