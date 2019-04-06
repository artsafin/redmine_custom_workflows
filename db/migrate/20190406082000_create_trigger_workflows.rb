class CreateTriggerWorkflows < ActiveRecord::Migration[5.2]
  def change
    create_table :trigger_workflow_modules do |t|
      t.string :name, limit: 1000
      t.string :comment, limit: 1000
      t.boolean :is_file
      t.text :helper
    end

    create_table :trigger_workflows do |t|
      t.belongs_to :trigger_workflow_module, index: true

      t.string :name, limit: 1000
      t.string :comment, limit: 1000
      t.integer :priority
      t.boolean :is_file
      t.boolean :is_enabled
      t.text :on_click
      t.text :after_click_success
      t.text :after_click_failure
    end

    create_table :triggers do |t|
      t.belongs_to :trigger_workflow, index: true
      t.string :title, limit: 1000
      t.string :position # details_bottom or description_bottom
      t.integer :priority
      t.string :css_classes, limit: 1000
    end
  end
end
