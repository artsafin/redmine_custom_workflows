class AddShowConditionToTriggerWorkflows < ActiveRecord::Migration[5.2]
  def change
    add_column :trigger_workflows, :show_condition, :text
  end
end
